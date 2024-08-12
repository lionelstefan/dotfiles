-- Import required Neovim APIs and Treesitter
local api = vim.api
local ts = vim.treesitter

-- Function to get the current open file path
local function get_current_file_path()
  return api.nvim_buf_get_name(0)
end

-- Function to get the latest version from CHANGELOG.md
local function get_latest_version()
  local changelog_path = "CHANGELOG.md"
  local latest_version = "0.0.0" -- Default version if none found

  -- Check if CHANGELOG.md exists
  if vim.fn.filereadable(changelog_path) == 1 then
    for line in io.lines(changelog_path) do
      if line:match("^## V ") then
        local version = line:match("V ([%d%.]+)")
        if version then
          latest_version = version
          break
        end
      end
    end
  end

  -- Increment the version
  local major, minor, patch = latest_version:match("(%d+)%.(%d+)%.(%d+)")
  major = tonumber(major)
  minor = tonumber(minor)
  patch = tonumber(patch)

  if patch == 9 then
    patch = 0
    if minor == 9 then
      minor = 0
      major = major + 1
    else
      minor = minor + 1
    end
  else
    patch = patch + 1
  end

  return string.format("%d.%d.%d", major, minor, patch)
end

-- Function to check if the docblock already exists after <?php tag and before namespace declaration
local function has_docblock()
  -- Use Treesitter to parse the current buffer
  local parser = ts.get_parser(0, "php")
  local tree = parser:parse()[1]
  local root = tree:root()

  -- Find the positions of php_tag and namespace nodes
  local php_tag_start, namespace_start

  for node in root:iter_children() do
    if node:type() == "php_tag" then
      php_tag_start = node:start()
    elseif node:type() == "namespace_name" then
      namespace_start = node:end_()
      break
    end
  end

  -- If no php_tag or namespace is found, return false
  if not php_tag_start or not namespace_start then
    return false
  end

  -- Get the lines of the current buffer
  local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Check for docblock in the range between php_tag and namespace
  for i = php_tag_start + 1, namespace_start - 1 do
    if buffer_lines[i]:match("^%s*/%*%*") then
      return true
    end
  end

  return false
end

-- Function to add phpdoc block
local function add_phpdoc_comment()
  local file_path = get_current_file_path()
  if file_path == '' then
    print('No file path found')
    return
  end

  -- Get the content of the current buffer
  local buffer_lines = api.nvim_buf_get_lines(0, 0, -1, false)

  -- Check if the file already has a docblock
  if has_docblock(buffer_lines) then
    print("Docblock already exists in the file.")
    return
  end

  -- Extract file name without extension
  local file_name_without_extension = vim.fn.fnamemodify(file_path, ':t:r')

  -- Get the next version
  local version = get_latest_version()

  -- Define the docblock
  local docblock = string.format([[
/**
 * %s
 *
 * @author Stefan <stefan.lionel@dflow.com.au>
 *
 * @since %s
 */
]], file_name_without_extension, version)

  -- Use Treesitter to parse the current buffer
  local parser = ts.get_parser(0, "php")
  local tree = parser:parse()[1]
  local root = tree:root()

  -- Find the first php_tag node
  for node in root:iter_children() do
    if node:type() == "php_tag" then
      local start_line = node:start()

      -- Insert the docblock after the php_tag
      api.nvim_buf_set_lines(0, start_line + 1, start_line + 1, false, { "" })
      api.nvim_buf_set_lines(0, start_line + 2, start_line + 2, false, vim.split(docblock, '\n'))
      return
    end
  end

  print("No <?php tag found in the file.")
end

-- Make the function global to be callable via Neovim command
_G.add_phpdoc_comment = add_phpdoc_comment
