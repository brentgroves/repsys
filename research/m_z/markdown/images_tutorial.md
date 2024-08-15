# **[images in markdown](https://tiiny.host/blog/images-in-markdown/)**

## Image Markdown and HTML

It is common to alter an image’s appearance on a web page or document. You may wish to resize, align, or add a title or caption.

## Here’s where it gets tricky

Three of the most common flavors of Markdown are:

- Markdown
- MultiMarkdown
- CommonMark

But writing your Markdown in one of these doesn’t assure compatibility with the Markdown processor used for interpreting it. You must write specifically for your processor or else be as generic as possible.

If you will be using your Markdown on multiple platforms or in various applications, you can’t be sure what syntax all those processors use.

Enter HTML.

NOTE: If you don’t know any HTML, it’s worth learning a bit. It gives you the flexibility to script anything you need in Markdown. Visit w3schools.com or another HTML tutorial site to get started.

Here are several examples of image manipulation in HTML that you can use in Markdown.

Basic image tag

```html
<img src="path-to-image.jpg" alt="Description of the image">
```

Change the image size

```html
<img src="image.jpg" alt="Description" width="300" height="200">
```

Style: Border

```html
<img src="image.jpg" alt="Description" style="border: 1px solid \#000;">
```

Style: Shadow

```html
<img src="image.jpg" alt="Description" style="box-shadow: 5px 5px 10px \#888;">
```
