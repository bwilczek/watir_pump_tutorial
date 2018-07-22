# WORK IN PROGRESS - NOTHING TO SEE HERE YET

## Page Object pattern with `WatirPump`: how to create and run tests

The goal of this repo is to familiarize web developers with features of `WatirPump` -
a new PageObject library for Ruby/Watir. Each section of this tutorial
covers another feature of `WatirPump`, gradually increasing the complexity.
Each one consists of a brief description and an example test (`rspec`).

The examples use static HTML pages that can be found in `docs` directory.
They are being served through GitHub Pages under [this link](https://bwilczek.github.io/watir_pump_tutorial/).
For the sake of local `rspec` execution `sinatra` server is being spin up to
serves these pages faster and without the necessity of being online.

Please refer to gem's [README](https://github.com/bwilczek/watir_pump)
for more comprehensive documentation on the API.

### 1. Pages

#### 1.1 Define a page and open it

#### 1.2 Navigate between two pages

#### 1.3 Declare custom condition for page being loaded

### 2. Elements

#### 2.1 Locate using the Watir way

#### 2.2 Locate using a lambda expression

#### 2.3 Collection of elements

#### 2.4 Action macros: reader

#### 2.5 Action macros: clicker

#### 2.6 Action macros: writer

### 3. Forms

#### 3.1 Fill in the form

#### 3.2 Fill in and submit the form

#### 3.3 Read values from the page

### 4. Components

#### 4.1 Define a component class and locate it on a page

#### 4.1 Nesting

#### 4.2 Collection of components

### 5. Other features

#### 5.1 Inheritance

#### 5.2 `query` macro
