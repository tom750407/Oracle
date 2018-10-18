# NODE - learnyounode

### Exercise 1 - Hello World
#### Task:  
Write a program that prints the text "HELLO WORLD" to the console (stdout).
#### Code:  
```javascript
console.log("HELLO WORLD");
```
#### Extend:
**process.stdout.write** can also use in printing line.  
But it only does a very basic functionality.  
Example A
```javascript
process.stdout.write("Hello World");
process.stdout.write("Testing");
```
Output
```javascript
Hello WorldTesting //If we don't put break line (\n) at the end, we will get a massive sentence
```
On the other hand **console.log** can do more.  
Example B
```javascript
console.log("Hello","World");
```
###
