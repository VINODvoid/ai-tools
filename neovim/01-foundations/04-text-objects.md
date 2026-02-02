# Text Objects: The Power Multiplier

*Mastering text objects will 10x your Neovim editing speed*

## What Are Text Objects?

Text objects are **smart selections** that understand code structure. Instead of carefully positioning your cursor, you operate on logical units: words, quotes, parentheses, blocks.

**The breakthrough**: You can be **anywhere** inside the text object!

---

## The Pattern: [operator][i/a][object]

```
c     i     w
│     │     │
│     │     └─ object (word, quote, paren, etc.)
│     └─────── i = inner, a = around
└───────────── operator (change, delete, yank)
```

### Examples
```vim
ciw    " Change Inner Word
da"    " Delete Around quotes (includes quotes)
yi(    " Yank Inner parentheses
```

---

## Inner (`i`) vs Around (`a`)

### Visual Comparison

```javascript
const message = "Hello World";
                 ^cursor here

ci":  const message = "|";        (inside quotes)
ca":  const message = |;          (includes quotes)

di":  const message = "|";        (deletes content)
da":  const message = |;          (deletes quotes too)
```

**Rule of thumb**:
- `i` = "inner" → contents only
- `a` = "around" → includes delimiters/whitespace

---

## Word Objects

### `iw` - Inner Word

```javascript
const userName = value;
      ^cursor anywhere on userName

ciw → const | = value;
      (changes just the word)
```

### `aw` - Around Word

```javascript
const userName = value;
      ^cursor anywhere on userName

daw → const | = value;
      (deletes word + trailing space)
```

### `iW` / `aW` - WORD (includes punctuation)

```javascript
const foo-bar-baz = value;
      ^cursor anywhere

diw → const foo-|-baz = value;    (stops at -)
diW → const | = value;            (treats foo-bar-baz as one WORD)
```

---

## Quote Objects

### Pattern: `i"` / `a"`

```javascript
const msg = "Hello World";
             ^cursor anywhere inside

ci" → const msg = "|";
      (change content)

da" → const msg = |;
      (delete string completely)
```

### All Quote Types

```vim
i" / a"    " Double quotes
i' / a'    " Single quotes
i` / a`    " Backticks
```

### Practice

```javascript
// Try these:
const name = "Alice";
const email = 'bob@example.com';
const template = `Hello ${name}`;

// Exercises:
// 1. Change "Alice" → ci" → "Bob"
// 2. Delete entire 'bob@example.com' → da'
// 3. Change template content → ci`
```

---

## Parentheses / Bracket Objects

### Parentheses: `i(` / `a(` (also `ib` / `ab`)

```javascript
function greet(name, age) {
               ^cursor anywhere here

ci( → function greet(|) {
      (deletes all params)

da( → function greet| {
      (deletes params and parens)
```

### Braces: `i{` / `a{` (also `iB` / `aB`)

```javascript
if (true) { console.log("hi"); }
            ^cursor anywhere inside

ci{ → if (true) { | }
      (deletes content)

da{ → if (true) |
      (deletes braces and content)
```

### Brackets: `i[` / `a[`

```javascript
const arr = [1, 2, 3];
             ^cursor inside

ci[ → const arr = [|];
      (clears array)
```

### Angle Brackets: `i<` / `a<`

```typescript
const list: Array<string> = [];
                  ^cursor here

ci< → const list: Array<|> = [];
```

---

## HTML/XML Tag Objects

### `it` / `at` - Tag Objects

```html
<div class="container">
  <span>Hello World</span>
</div>

<!-- Cursor on "Hello World" -->
dit → <span>|</span>
      (deletes content)

dat → <div class="container">
        |
      </div>
      (deletes entire span tag)
```

### Nested Tags

```html
<div>
  <p>Some <strong>important</strong> text</p>
</div>

<!-- Cursor on "important" -->
dit → <strong>|</strong>
      (deletes "important")

dat → <p>Some | text</p>
      (deletes <strong> tag)
```

---

## Paragraph Objects

### `ip` / `ap` - Paragraph

```javascript
// Paragraph 1
const x = 1;
const y = 2;

// Paragraph 2
const z = 3;
const w = 4;

// Cursor anywhere in paragraph 1
dap → // Paragraph 2
      const z = 3;
      const w = 4;
      (deleted entire paragraph 1)

yap → (yanks entire paragraph including blank lines)
```

**Use case**: Delete or copy chunks of code

---

## Sentence Objects

### `is` / `as` - Sentence

```
This is sentence one. This is sentence two. This is sentence three.
                      ^cursor here

dis → This is sentence one. | This is sentence three.
      (deletes sentence two)
```

**Use case**: Editing documentation or comments

---

## Practical Examples

### Example 1: Change Function Name

```javascript
function calculateTotal(price, tax) {
         ^cursor anywhere on "calculateTotal"
    return price + tax;
}

// Do: ciw → type "computeSum"
// Result:
function computeSum(price, tax) {
    return price + tax;
}
```

### Example 2: Clear Function Body

```javascript
function process() {
    const x = 1;
    const y = 2;
    return x + y;
}

// Cursor anywhere inside braces
// Do: di{
// Result:
function process() {
    |
}
```

### Example 3: Delete Function Call Arguments

```javascript
console.log("debug", user, settings);
            ^cursor anywhere in arguments

// Do: di(
// Result:
console.log(|);
```

### Example 4: Change Object Property Value

```javascript
const config = {
    theme: "dark",
    fontSize: 16
};

// Cursor on "dark"
// Do: ci" → type "light"
// Result: theme: "light"
```

### Example 5: Wrap Code in Try-Catch

```javascript
const result = apiCall();
process(result);

// Select lines with Vj (visual line)
// Then: >  (indent)
// Then: O try { <Esc>
// Then: }o catch(e) { console.error(e); } <Esc>

// Better with macro!
```

---

## Combining Text Objects with Operators

### Delete Operator

```vim
dw      " Delete word (old way)
diw     " Delete inner word (better - position independent!)
da"     " Delete around quotes
di(     " Delete function arguments
daB     " Delete block including braces
dap     " Delete paragraph
```

### Change Operator

```vim
cw      " Change word (old way)
ciw     " Change inner word (MASTER THIS!)
ci"     " Change string content
ci(     " Change function parameters
ci{     " Change block content
cit     " Change tag content
```

### Yank Operator

```vim
yw      " Yank word (old way)
yiw     " Yank inner word
yi"     " Yank string without quotes
ya"     " Yank string with quotes
yi(     " Yank function arguments
yap     " Yank paragraph
```

### Visual Select

```vim
viw     " Visual select word
vi"     " Visual select inside quotes
vi(     " Visual select inside parens
vit     " Visual select inside tag
vap     " Visual select paragraph
```

### Indent

```vim
>iw     " Indent word (doesn't make sense)
>i{     " Indent inside braces
>ap     " Indent paragraph
>aB     " Indent block
```

---

## Advanced Text Objects (with Treesitter)

If you have `nvim-treesitter-textobjects` installed:

### Function Objects

```vim
af / if    " Around/Inside function
```

```javascript
function calculate(x, y) {
    return x + y;
}

// Cursor anywhere in function
daf → |
      (deletes entire function)

yif → (yanks function body only)
```

### Class Objects

```vim
ac / ic    " Around/Inside class
```

```javascript
class User {
    constructor(name) {
        this.name = name;
    }
}

// Cursor anywhere in class
dac → |
      (deletes entire class)
```

### Parameter Objects

```vim
aa / ia    " Around/Inside argument
```

```javascript
function greet(name, age, city) {
                   ^cursor on age
    // ...
}

dia → function greet(name, |, city) {
      (deletes "age")

daa → function greet(name, |city) {
      (deletes "age," including comma)
```

---

## Practice Exercises

### Exercise 1: Word Changes

```javascript
const firstName = "value";
const lastName = "value";
const userName = "value";
const userEmail = "value";

// Do these:
// 1. Change firstName to fullName (ciw)
// 2. Change lastName to surname (ciw)
// 3. Change all "value" strings to "test" (ci")
```

### Exercise 2: Quote Operations

```javascript
const message = "Hello World";
const title = 'Important';
const template = `Result: ${value}`;

// Do these:
// 1. Delete "Hello World" but keep quotes (di")
// 2. Delete 'Important' including quotes (da')
// 3. Change template content (ci`)
```

### Exercise 3: Function Edits

```javascript
function calculate(price, quantity, tax) {
    console.log("Calculating...");
    const total = price * quantity * tax;
    return total;
}

// Do these:
// 1. Delete all parameters (di()
// 2. Change "Calculating..." (ci")
// 3. Delete function body (di{)
// 4. Delete entire function (daB or da{)
```

### Exercise 4: HTML Tags

```html
<div class="container">
    <h1>Title Here</h1>
    <p>Paragraph content goes here.</p>
</div>

<!-- Do these: -->
<!-- 1. Change "Title Here" (cit) -->
<!-- 2. Delete <h1> tag completely (dat) -->
<!-- 3. Change paragraph content (cit) -->
```

### Exercise 5: Mixed Operations

```javascript
const config = {
    server: "localhost:3000",
    database: {
        host: "127.0.0.1",
        port: 5432
    }
};

// Do these:
// 1. Change "localhost:3000" (ci")
// 2. Delete database object content (di{) - cursor in inner {}
// 3. Change port value (ciw)
// 4. Delete entire config object (daB)
```

---

## Common Patterns

### Pattern 1: Change Variable Name

```javascript
const oldName = value;
      ^
ciw → newName
```

### Pattern 2: Clear String Content

```javascript
const msg = "some text";
             ^
ci" → (empty string ready for new content)
```

### Pattern 3: Replace Function Params

```javascript
function greet(name, age, email) {
               ^
ci( → user
// Result: function greet(user) {
```

### Pattern 4: Extract from Quotes

```javascript
const url = "https://example.com";
             ^
yi" → clipboard: https://example.com
// (without quotes)

ya" → clipboard: "https://example.com"
// (with quotes)
```

---

## Speed Test

Can you complete this in under 2 minutes?

```javascript
// Starting code:
const userName = "oldValue";
const userEmail = "old@example.com";

function processUser(name, email, age) {
    console.log("Processing...");
    return { success: false };
}

// Tasks:
// 1. Change "oldValue" to "newValue"
// 2. Change "old@example.com" to "new@example.com"
// 3. Delete all function parameters
// 4. Change "Processing..." to "Done"
// 5. Change false to true
// 6. Delete entire function body

// Do it!
```

**Commands**:
1. `ci"` → "newValue"
2. `ci"` → "new@example.com"
3. `di(` → empty params
4. `ci"` → "Done"
5. `ciw` → true
6. `di{` → empty function

---

## Why Text Objects Matter

### Without Text Objects (Old Way)

```javascript
const message = "Hello World";
                ^cursor must be at H

// Change string:
f" → l → v → t" → c → type new text
// (find quote, move right, visual, till quote, change)
```

### With Text Objects (New Way)

```javascript
const message = "Hello World";
                      ^cursor can be ANYWHERE

ci" → type new text
// (done!)
```

**10x faster because**:
- No precise cursor positioning
- One command instead of 5-6
- Works from anywhere in object
- Muscle memory builds faster

---

## Mastery Checklist

Before moving forward, you should:

- [ ] Know `iw` vs `aw`
- [ ] Master `ciw` (change word)
- [ ] Master `ci"` (change in quotes)
- [ ] Master `ci(` (change in parentheses)
- [ ] Master `ci{` (change in braces)
- [ ] Understand `i` vs `a` clearly
- [ ] Use `dap` (delete paragraph)
- [ ] Use `yap` (yank paragraph)
- [ ] Use `dit` / `dat` for HTML (if applicable)
- [ ] Prefer text objects over manual selection

---

## Quick Reference

```
# Word
iw / aw       inner/around word

# Quotes
i" / a"       inner/around double quotes
i' / a'       inner/around single quotes
i` / a`       inner/around backticks

# Brackets
i( / a(       inner/around parentheses (also ib/ab)
i{ / a{       inner/around braces (also iB/aB)
i[ / a[       inner/around brackets
i< / a<       inner/around angle brackets

# Code Blocks
it / at       inner/around HTML/XML tag
ip / ap       inner/around paragraph
is / as       inner/around sentence

# With Treesitter
af / if       around/inside function
ac / ic       around/inside class
aa / ia       around/inside argument
```

---

## Next Steps

1. Practice these for 2-3 days
2. Use in real code daily
3. When automatic, move to: `05-search-and-replace.md`

**Text objects are THE key to Neovim mastery. Don't skip this!**

---

**[← Previous: Editing Basics](03-editing-basics.md) | [Next: Search & Replace →](05-search-and-replace.md)**
