local M = {}

function M.process_metadata()
  -- Store current register states
  local saved_unnamed = vim.fn.getreginfo('"')
  local saved_clipboard = vim.fn.getreginfo('+')

  -- Read buffer lines
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local has_album_gain = vim.fn.search('^replaygain_album_gain = ', 'nw') > 0
  local has_albumartists = vim.fn.search('^albumartists = ', 'nw') > 0

  -- Identify all ARTIST lines
  local artist_lines = {}
  for _, line in ipairs(lines) do
    if line:match("^artist = ") then
      table.insert(artist_lines, line)
    end
  end

  local all_artists_same = #artist_lines > 0
  for i = 2, #artist_lines do
    if artist_lines[i] ~= artist_lines[1] then
      all_artists_same = false
      break
    end
  end

  -- 1. General Deletions (Black hole)
  vim.cmd([[silent! %g/^\(replaygain_track_peak\|replaygain_album_peak\|original_date\|original_yyyy_mm\|date_added\) = /d _]])

  -- 2. Conditional Artist Deletion
  if all_artists_same then
    vim.cmd([[silent! %g/^artist = /d _]])
  end

  -- 3. Conditional Gain Removal
  if has_album_gain then
    vim.cmd([[silent! %g/^replaygain_track_gain = /d _]])
  end
  vim.cmd([[silent! %g/^replaygain_album_gain = /d _]])

  -- 4. Tag Duplication/Renaming
  if not has_albumartists then
    vim.cmd([[silent! %s/^\(custom_albumartist\) = \(.*\)/albumartists = \2\r\1 = \2/ge]])
  end

  -- 5. Swap Album/Artist Order
  vim.cmd([[silent! %s/^\(album = .*\)\n\(albumartists\? = .*\)/\2\r\1/ge]])

  -- 6. Formatting (Numbers & Quotes)
  vim.cmd([[silent! %s/tracknumber = "0*\(\d\+\)"/tracknumber = \1/ge]])
  vim.cmd([[silent! %s/discnumber = "0*\(\d\+\)"/discnumber = \1/ge]])
  vim.cmd([[silent! %g/^unix_added_\(foobar\|applemusic\|youtube\)/s/"//ge]])

  -- 7. Whitespace Management
  vim.cmd([[silent! %s/^\[album\]$/[album]\r/ge]])
  vim.cmd([[silent! %s/\n\{3,}/\r\r/ge]])

  -- 8. Save
  vim.cmd("silent! write")

  -- Restore Registers
  vim.fn.setreg('"', saved_unnamed)
  vim.fn.setreg('+', saved_clipboard)
end

return M
