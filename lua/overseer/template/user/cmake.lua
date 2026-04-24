-- Template customizado para CMake no Overseer
-- Salve este arquivo em: lua/overseer/template/user/cmake.lua

return {
  name = "CMake",
  desc = "Build with CMake",
  params = {
    { name = "build_dir", desc = "Build directory", default = "build" },
    { name = "build_type", desc = "Build type (Debug/Release)", default = "Debug" },
  },
  builder = function(params)
    return {
      cmd = "cmake",
      args = {
        "-B",
        params.build_dir,
        "-DCMAKE_BUILD_TYPE=" .. params.build_type,
      },
      cwd = vim.fn.getcwd(),
    }
  end,
}
