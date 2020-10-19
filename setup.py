from cx_Freeze import setup, Executable

base = None

executables = [Executable("create_plot.py", base=base)]

packages = ["pandas","os","ipykernel","matplotlib"]
options = {
    'build_exe': {
        'packages':packages,
    },
}

setup(
    name = "<any name>",
    options = options,
    version = '0.0.1',
    description = '<any description>',
    executables = executables
)