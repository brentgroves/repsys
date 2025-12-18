# **[Manipulating the DOM with Refs](https://react.dev/learn/manipulating-the-dom-with-refs)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Manipulating the DOM with Refs
React automatically updates the **[DOM](https://developer.mozilla.org/docs/Web/API/Document_Object_Model/Introduction)** to match your render output, so your components won’t often need to manipulate it. However, sometimes you might need access to the DOM elements managed by React—for example, to focus a node, scroll to it, or measure its size and position. There is no built-in way to do those things in React, so you will need a ref to the DOM node.

## Getting a ref to the node 
To access a DOM node managed by React, first, import the useRef Hook:

```jsx
import { useRef } from 'react';
```

Then, use it to declare a ref inside your component:

```jsx
const myRef = useRef(null);
```

Finally, pass your ref as the ref attribute to the JSX tag for which you want to get the DOM node:

```jsx
<div ref={myRef}>
```

The useRef Hook returns an object with a single property called current. Initially, myRef.current will be null. When React creates a DOM node for this ```<div>```, React will put a reference to this node into myRef.current. You can then access this DOM node from your **[event handlers](https://react.dev/learn/responding-to-events)** and use the built-in **[browser APIs](https://developer.mozilla.org/docs/Web/API/Element)** defined on it.

```jsx
// You can use any browser APIs, for example:
myRef.current.scrollIntoView();
```

Example: Focusing a text input 
In this example, clicking the button will focus the input:


```jsx
import { useRef } from 'react';

export default function Form() {
  const inputRef = useRef(null);

  function handleClick() {
    inputRef.current.focus();
  }

  return (
    <>
      <input ref={inputRef} />
      <button onClick={handleClick}>
        Focus the input
      </button>
    </>
  );
}

```