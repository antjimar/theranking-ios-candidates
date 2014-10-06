The Ranking iOS dev test
=========================

This repository is aimed to test future iOS developers skills.
We hope you enjoy as much as we do coding and pushing your skills with new challenges.

## Introduction

In order to evaluate your skills and coding style we would like you to develop a small application that consumes 500px API RESTFull services.

## Use case

We would like to have an small application that has two main views. The first one will be a list of the most popular pictures from 500px. The second one will be a view with as mush details about a concreate picture as possible.

* The first time the user launches our app, he should see a list of most popular pictures from 500px. This view must have a list with square cells showing most popular pictures. Each cell must have at the bottom of them the name of the picture, and at the top right corner the rating score. This list must be ordered by the rating score from higher to lower. The user must be able to select one the pictures from this list.
* If the user selects a picture from the previous list, the app must show another view with the details of the selected picture. In this detailed view the user would like to see the following details, in the following order:
  - The name and the description of the picture (if available).
  - Info about he user who took the picture. At least his/her avatar(rounded) and name.
  - Some information about the camera used to take the picture.
  - A small map showing where the picture was taken (if available).

## How to get started

* Check out the [500px API documentation](https://github.com/500px/api-documentation) to know how to get the information this test requires. We recomend candidates to check [GET Photos method](https://github.com/500px/api-documentation/blob/master/endpoints/photo/GET_photos.md) and explore the parameters of this method to get the right pictures.

## Procedure

* Fork this repository and work on your own fork.
* When you think your app matches the requirements and you are proud of the code you are going to push, make a pull request to this repository. We will review your code and we will likely make some comments about your code.
* In your pull request, add a description of the solution you have implemented and any other issue we should take into account at the time of review.

## Requirements

* Candidates are not allowed to use third party libraries. It is only allowed the use of third party libraries to load asychronously images. In this case, candidates must use [Cocoapods](http://cocoapods.org/) to handle dependences. If candidates still need to use any other third party library, they must justify their use.
* Storyboards are not allowed. Candidates can use NIB files but not Storyboards.
* The candidate must chose the UI that fits better the requirements but the UI must be done using Auto Layout constraints.
* Candidates have three days to present a pull request with a solution, but the sooner the candidate presents a solution more chances the candidate will have.

## Optional

* We will value the use of Core Data.
* The use of animations will be a plus.

## Advices

* Although it is a small application, we would like to see the right use of [SOLID](http://en.wikipedia.org/wiki/SOLID_(object-oriented_design)) principles.
* Knowledge of design patterns.
* Clean code.

The ranking team wishes all candidates good luck and we are looking forward to see your code. Get dirty!
If you need help do not hesitate to contact us.

