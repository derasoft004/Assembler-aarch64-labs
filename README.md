to launch use 
```
as -o <file_name>.o <file_name>.s

ld -o <file_name> <file_name>.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e <entry_point> (обычно это _main)

./<file_name>
```
По умолчанию в качестве точки входа в программу компоновщик рассматривает метку _main, с помощью этого параметра сообщаем компоновщику, что точка входа - <entry_point> (например _start)
