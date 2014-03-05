#Spaced Repetition Flashcard System

This is a spaced repetition flashcard system built using Ruby on Rails. The front-end is designed to work on mobile devices as well as in the web browser on a desktop computer.

The underlying algorithm, which is based on a modified version of the SM2 algorithm, is built using principles obtained from research into the pshychology of memory. The result is an application that can assist the user with memorisation of large amounts of information with very little time investment.

Use cases include language learning, memorisation of abbreviations or technical terms, exam practice, and much more.

Statistics are logged to allow the user to monitor their progress. The data can be visualised with various charts on the stats page that are generated using Highcharts.

## Front-end
* Foundation 5
* SCSS
* jQuery
* Highcharts

## Back-end
* Ruby on Rails
* SQLite3 (plans to replace with MongoDB at a later date)
* SM2 implemented in Ruby

## Testing
* RSpec
* Capybara
* Guard
* Launchy

## Utilities
* Growl notify

Built by Freddie Coleman @ Bournemouth University 2014