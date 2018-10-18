# NODE - learnyounode

## Exercise 1 - Hello World
### Task:  
Write a program that prints the text "HELLO WORLD" to the console (stdout).
### Code:  
```javascript
console.log("HELLO WORLD");
```
### Extend:
#### process.stdout.write
```
This can also use in printing lines.  
But it only does a very basic functionality.  
```
#### Example A
```javascript
process.stdout.write("Hello World");
process.stdout.write("Testing"); //If we don't put break line (\n) at the end, two sentences will be merged into one
```
#### Output
```
Hello WorldTestig
```
#### console.log
```
On the other hand **console.log** can do more.  
```
#### Example B
```javascript
console.log("Hello World"); 
console.log("Testing"); //We don't need the break line, because it was already formated
```
#### Output
```
Hello World
Testing
```
#### Example C
```javascript
console.log("Hello World\n","Testing"); //We can write more than one string
```
#### Output
```
Hello World
Testing
```
#### Example D
```javascript
var text = "Testing";
console.log("Hello World\n%s",text); //We can make associations
```
#### Output
```
Hello World
Testing
```
###
