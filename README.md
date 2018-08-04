## Page Object pattern with `WatirPump`: how to create and run tests

The goal of this repo is to familiarize web developers with features of `WatirPump` -
a new PageObject library for [Watir](https://www.rubydoc.info/gems/watir/). Each section of this tutorial
covers another feature of `WatirPump`, gradually increasing the complexity.
Each one consists of a brief description and an example test (`rspec`).

The examples use static HTML pages that can be found in `docs` directory.
They are being served through GitHub Pages under [this link](https://bwilczek.github.io/watir_pump_tutorial/).
For the sake of local `rspec` execution `sinatra` server is being spin up to
serves these pages faster and without the necessity of being online.

Please refer to WatirPump's [README](https://github.com/bwilczek/watir_pump)
for more comprehensive documentation on the API.

### 1. Pages

#### 1.1 Define a page and open it

[see the spec](spec/1.1_page_define_and_open_spec.rb)

#### 1.2 Navigate between two pages

[see the spec](spec/1.2_navigation_between_two_pages_spec.rb)

#### 1.3 Declare custom condition for page being loaded

[see the spec](spec/1.3_custom_loaded_condition_spec.rb)

#### 1.4 Parametrize URI

WatirPump internally uses [addressable](https://github.com/sporkmonger/addressable) gem to support URL parametrization.

[see the spec](spec/1.4_parametrize_uri_spec.rb)

#### 1.5 Inheritance

Parts that are common to several pages can be extracted to a shared base page and inherited.

Example specs to be added in the future.

### 2. Elements

#### 2.1 Locate using Watir methods

[see the spec](spec/2.1_locate_using_watir_methods_spec.rb)

#### 2.2 Locate using a lambda expression

There are two ways of addressing elements with a lambda:
 1. using element type specific Watir methods [see the spec](spec/2.2.1_locate_using_lambda_spec.rb)
 1. using element type agnostic `element` method [see the spec](spec/2.2.2_locate_using_element_method.rb)

#### 2.3 Collection of elements

Works similarly as single elements. Use `watir` methods that return collections (e.g. `links`, `buttons`, etc.) to find out.

Example specs to be added in the future.

#### 2.4 Action macros: reader

[see the spec](spec/2.4_action_macro_reader_spec.rb)

#### 2.5 Action macros: clicker

[see the spec](spec/2.5_action_macro_clicker_spec.rb)

#### 2.6 Action macros: writer

[see the spec](spec/2.6_action_macro_writer_spec.rb)

#### 2.7 `query` class macro

Use it as a shorthand for instance method creation. Parameters are accepted and no validation of returned value is performed.

Example specs to be added in the future.

### 3. Forms

#### 3.1 Fill in the form

[see the spec](spec/3.1_fill_form_spec.rb)

#### 3.2 Fill in and submit the form

[see the spec](spec/3.2_fill_submit_form_spec.rb)

#### 3.3 Read values from the page

[see the spec](spec/3.3_big_form_spec.rb)

### 4. Components

#### 4.1 Define a component class and locate it on a page

[see the spec](spec/4.1_component_definition_spec.rb)

#### 4.2 Nesting

[see the spec](spec/4.2_component_nesting_spec.rb)

#### 4.3 Collection of components

[see the spec](spec/4.3_component_collection_spec.rb)
