to launch use 
```
as -o <file_name>.o <file_name>.s

ld -o <file_name> <file_name>.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e <entry_point> (обычно это _main)

./<file_name>
```
По умолчанию в качестве точки входа в программу компоновщик рассматривает метку _main. В нашей же программу такой точкой входа, с которой начинается программа, является метка _start. И с помощью этого параметра сообщаем компоновщику, что точка входа - _start
