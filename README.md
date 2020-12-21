# README for Pandoc Helper App (MacOS)

by Geoff Lambeth (geofflambeth@gmail.com)

## Getting started

If you have not already done so, install pandoc from the pandoc-2.11.2-macOS.pkg included in this folder. Check the [Pandoc Github](https://github.com/jgm/pandoc/releases/) if you are concerned that this may no longer be the most current version of pandoc.

## To Install Pandoc Helper.app

Drag and drop Pandoc Helper.app into your applications folder to install.

Double click the application to get started.

After attempting to start the application, you may warned that you cannot open the application because I am not an identified Mac developer.

Navigate to System Preferences > Security & Privacy > General. Under "Allow apps downloaded from," you should see a warning about the application you just tried to open (Pandoc Helper).

Select "Open anyway."

The application should now be ready to be used and can be added to your dock.

## Using Pandoc Helper.app

Feel free to drag and drop files onto the application icon. This will speed up the process of selecting your markdown file.

You can also run the application by double clicking and then following the prompts on the screen.

Pandoc Helper.app will always create a .docx or .icml file with the same filename as your original file within the same parent folder. For other uses, please use pandoc in the mac terminal. Feel free to ask me for help if necessary.

**Please note: This application will only work on markdown, html, and docx files.** All normal pandoc warnings apply, as this application will **NOT** warn you before overwriting the existing word document or InCopy file.

## Installing LaTeX (optional)

**WARNING:** This is an advanced step. This installation will require homebrew and can be done in many different ways. I recommend setting your mac terminal to use bash and then using homebrew. *If you are not comfortable working with command line, please contact someone who is before attempting this installation.*

To create PDFs using this pandoc helper application, you will need to install LaTeX. I recommend installing the basictex version—which will use less space on your drive—using the following code in the terminal.

1. First, set your terminal to bash. This will not be necessary if you are using an older version of mac.

```
chsh -s /bin/bash
```

2. Install basictex using homebrew. If homebrew is not installed, you will need to install it following instructions from me or from the internet.

```
brew install --cask basictex
```

3. Follow the directions in your terminal to complete the installation.

If PDF creation using this pandoc helper continues to not work, please contact me for help.