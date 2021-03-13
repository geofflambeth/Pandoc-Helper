# README for Pandoc Helper App (MacOS) v0.3

by Geoff Lambeth (geofflambeth@gmail.com)

## Getting started

If you have not already done so, install command line pandoc from the installation package included in the Accompanying Materials folder. Alternatively, check the [Pandoc Github](https://github.com/jgm/pandoc/releases/) (https://github.com/jgm/pandoc/releases/) to check for the most current version of pandoc. This shell has been tested with pandoc version 2.12

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

Pandoc Helper will always create converted files using the same filename as your original document within the same parent folder. For other uses, please use pandoc in the mac terminal.

All normal pandoc warnings apply, as this application will **NOT** warn you before overwriting existing files. This could be either a feature or a flaw of this shell depending on your intentional use of the application.

## Installing LaTeX (optional)

**WARNING:** This is a more advanced step. This installation will require homebrew and can be done in many different ways. I recommend setting your mac terminal to use bash and then using homebrew. *If you are not comfortable working with command line, please contact someone who is before attempting this installation.*

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
