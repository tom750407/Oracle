# NODE - learnyounode

## Exercise 1 - Hello World
### Task:
```
Write a program that prints the text "HELLO WORLD" to the console (stdout).
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
### Extend:
#### process.stdout.write
```
This can also use in printing lines, but it only does a very basic functionality.
```
#### Example A
```javascript
process.stdout.write("Hello");
process.stdout.write("World"); //If we don't put break line at the end, two sentences will be merged into one
```
#### Output
```
HelloWorld
```

---
#### console.log
```
On the other hand this can do more.  
```
#### Example B
```javascript
console.log("Hello"); 
console.log("World1"); //We don't need the break line, because it was already formated
--------------------------------------------------------------------------------
console.log("Hello","\nWorld2"); //We can write more than one string
--------------------------------------------------------------------------------
var text = "World3";
console.log("Hello\n%s",text); //We can make associations
```
#### Output
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
Write a program that accepts one or more numbers as command-line arguments and prints the sum of those numbers to the console (stdout).
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
