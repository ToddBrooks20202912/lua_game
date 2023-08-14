function love.conf(t) -- "t" is a table, able to pass in information to the main program we can use
  t.identity = "data/save"
  t.console = true
  t.externalstorage = false
  t.gammacorrect = true
  t.window.title = "Test"
  t.window.icon = ""
  t.window.display = 2
end
