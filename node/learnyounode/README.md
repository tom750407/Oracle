# NODE - learnyounode
## Exercise 1 - Hello World
### Task:
```
  Write a program that prints the text "HELLO WORLD" to the console
  (stdout).
```
---
### Code:
```javascript
console.log("HELLO WORLD");
```
---
### Result:
```
PS C:\Users\tsuochiayang\Desktop\Oracle\node> node .\Hello_World.js
HELLO WORLD
```
---
### Extension:
#### process.stdout.write
```
This can also use in printing lines, but it only does a very basic functionality.
```
#### Example
```javascript
process.stdout.write("Hello");
process.stdout.write("World"); //If we don't put break line at the end, two sentences will be merged into one
```
#### Result
```
HelloWorld
```
---
#### console.log
```
On the other hand this can do more.  
```
#### Example
```javascript
console.log("Hello"); 
console.log("World1"); //We don't need the break line, because it was already formated
--------------------------------------------------------------------------------
console.log("Hello","\nWorld2"); //We can write more than one string
--------------------------------------------------------------------------------
var text = "World3";
console.log("Hello\n%s",text); //We can make associations
```
#### Result
```
Hello
World1
--------------------------------------------------------------------------------
Hello
World2
--------------------------------------------------------------------------------
Hello
World3
```
---
## Exercise 2 - Baby Steps
### Task:
```
  Write a program that accepts one or more numbers as command-line arguments
  and prints the sum of those numbers to the console (stdout).
```
---
### Code:
```javascript
var result = 0;
for(var i = 2; i < process.argv.length; i++) {
    result += Number(process.argv[i]);
}
console.log(result);
```
---
### Result:
```
PS C:\Users\tsuochiayang\Desktop\Oracle\node> node .\Baby_Steps.js 1 2 3
6
```
---
### Extension:
```
Element to the process.argv array
The first element (process.argv[0]) will be process.execPath or 'node'
The second element (process.argv[1]) will be the path to the js file
The remain element (process.argv[2~n]) will be the command line arguments
```
#### Example
```javascript
console.log(process.argv); //index start with 0
```
#### Result
```
PS C:\Users\tsuochiayang\Desktop\Oracle\node> node .\test.js 1 2 3
[ 'C:\\Program Files\\nodejs\\node.exe',
  'C:\\Users\\tsuochiayang\\Desktop\\Oracle\\node\\test.js',
  '1',
  '2',
  '3' ]
```
---
## Exercise 3 - My First I/O
### Task:
```
  Write a program that uses a single synchronous filesystem operation to
  read a file and print the number of newlines (\n) it contains to the
  console (stdout), similar to running cat file | wc -l.

  The full path to the file to read will be provided as the first
  command-line argument (i.e., process.argv[2]). You do not need to make
  your own test file.
```
### Code:
