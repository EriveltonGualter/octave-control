function isaxes = isaxes(ax)
  try
    isaxes = strcmp(get(ax, 'type'), 'axes');
  catch
    isaxes = false;
  end
end