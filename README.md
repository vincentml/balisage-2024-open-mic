# It’s possible, but how? An easy approach to making tools work together (BaseX, Saxon, Java, Docker, and GitHub Actions)

This repository was created for an open mic talk that I (Vincent Lizzi) presented at the [Balisage](https://balisage.net) conference in 2024 to demonstrate a way to easily make a selection of useful tools work together. 

- [BaseX](https://basex.org) - XQuery processor and database
- [Saxon](https://www.saxonica.com/) - XSLT and XQuery processor
- [XSpec](https://github.com/xspec/xspec) - Testing framework for XSLT, XQuery, and Schematron
- [Java](https://www.java.com/) - programming language with a vast array of available libraries
- [Jetty](https://jetty.org) - Web server bundled with BaseX
- [Docker](https://www.docker.com) - Containers for packaging and deployment
- [GitHub Actions](https://docs.github.com/en/actions) - Automation service from GitHub
- [Gradle](https://gradle.org) - Build system, dependency manager, and multitool

These tools can be used to do a great many things individually and together. The point of this repository is not to show how to use the individual tools, but to show a way of getting the tools to work together in harmony. The approach shown here is by no means the only way, and there are many options to customize things to your own liking. The user is encouraged to reuse and adapt what is here to suite individual needs.

## Scope

This repository provides examples of how BaseX, Saxon, XSpec, Docker, GitHub Actions, and Gradle can be used together easily. 

This is not intended as a tutorial on each of the tools and technologies that are used. There are already tutorials, documentation, books, and training available.

## Requirements

A recent version of Java JDK must already be installed. Java JDK is available from several providers, including https://adoptium.net.

These examples were created on a Windows computer using Java version 17 but should work well on Linux based operating systems. The only Windows-specific things here are the `.cmd` scripts (which could easily be copied into shell scripts).

## How can I run Gradle tasks?

At some point you may need to run a Gradle task directly, and if you haven't used Gradle before this might need an explanation.

Open a terminal or command prompt in the same folder as this `README.md` file where the `gradlew.bat` and `gradlew` files are also found. 

Type in the command `gradlew` or `.\gradlew.bat` or `./gradlew` (one of these should work depending on what kind of terminal you are using). Next type the name of the Gradle task. For example:

    .\gradlew.bat basex_gui

The first time Gradle runs (or encounters a new dependency) it automatically downloads the files that are required.

## How can I specify which version of BaseX, Saxon, and XSpec I want to use?

In `build.gradle` update the version numbers on these lines. Gradle's dependency management takes care of downloading and using the version that you specify. 

```groovy
def basexVersion = '11.1'
def jettyVersion = '11.0.22'
def saxonVersion = '12.4'
def xspecVersion = '3.0.3'
```

Note: When updating BaseX to a different version also update the version of Jetty to match the version that version of BaseX uses. Also check which http port the version of BaseX uses (either 8080, 80, or 8984).


## How can I open BaseX?

Run `basex.cmd` found in the `bin` folder. 

This script runs Gradle task `basex_gui`, which launches the BaseX graphical user interface (GUI).


## How can I run an XQuery (using Gradle) without opening BaseX?

As an example run `process1.cmd` found in the `bin` folder.

This script runs Gradle task `process1`, which runs XQuery `src\xquery\process1.xq` using BaseX.

What process1.xq does not important. It simply takes all files that it finds in the "files\in" folder and writes a zip file to the "files\out" folder. This example illustrates running an XQuery that takes some files as input and produces files as output using BaseX and Gradle. This example also shows how command line parameters can be passed to XQuery as external variables.

You can copy process1 to make processes that use XQuery to do far more interesting things.

## How can I run an XSLT using Saxon and Gradle?

As an example run `process2.cmd` found in the `bin` folder.

This script runs Gradle task `process2`, which runs XSLT "src\xslt\process2.xsl" with "src\xslt\process2.xml" as input using Saxon, and saves the result to "files\out\process2.html"

What process2.xsl does is not important. It simply takes an XML document and transforms it to HTML. This example illustrates running an XSLT that takes a file as input and produces an output file using Saxon and Gradle.

You can copy process2 to make processes that use XSLT to do far more interesting things.

## How can I create a web-based interface using XQuery and BaseX?

Have a look at `src\webapp\home.xqm` in the BaseX GUI. The functions in this XQuery module are examples of using RESTXQ. Any XQuery modules that are placed in the `webapp` folder and have RESTXQ annotations will be used by BaseX to respond to HTTP requests.

Run `start.cmd` found in the `bin` folder.

This script runs Gradle task `basex_http_start` which launches BaseX and Jetty to run in background.

To stop this background service run `stop.cmd` found in the `bin` folder. This script runs the Gradle task `basex_http_stop`.

It is also possible to run Gradle task `basex_http` which launches BaseX and Jetty in foreground. This can sometimes be useful to see error messages.

While the service is running logs are saved in the `data\.logs` folder.

It is a helpful convention to place code and other files that are being created and version controlled within a folder called `src`. The BaseX configuration option `WEBPATH` is configured in `gradle.properties` to use the `src\webapp` folder.

See the BaseX documentation on [RESTXQ](https://docs.basex.org/main/RESTXQ).

## How can I run an XSLT using BaseX?

Have a look at function `xslt` in `src\webapp\home.xqm`. This function runs the XSLT `process2.xsl` and returns the output to the web browser.

Also have a look in the BaseX documentation on [XSLT Functions](https://docs.basex.org/main/XSLT_Functions) and the Saxonica documentation on [XSLT](https://www.saxonica.com/documentation12/index.html#!xsl-elements)


## How can I use Java (custom code) from BaseX?

Have a look at `src\webapp\home.xqm` and `src\java\main\example\MyJava.java`.

Function `greet1` calls a static method `greet1()` in the `MyJava` class.

Function `greet2` creates an instance of the `MyJava` class and calls the method `greet2()`.

Function `S3Download` provides an example of using a custom Java class `AwsS3Facade` as a facade (a wrapper) to more easily use the functionality of a publicly available Java library.

Gradle automatically handles compiling the `.java` files and creating a `.jar` file, and makes the compiled code available on the Java classpath. The `build.gradle` file contains configurations to make this work, for instance by specifying that the Java source code is in the `src\java\main` folder.

Have a look in the BaseX documentation on [Java Bindings](https://docs.basex.org/main/Java_Bindings)


## How can I have XQuery modules loaded automatically by BaseX?

Have a look at `src\startup\modules.xq` and Gradle task `basex_modules`.

Also have a look in the BaseX documentation on modules [Repository](https://docs.basex.org/main/Repository).

## How can I have scheduled jobs run automatically by BaseX?

Have a look at `src\startup\jobs.xq` and Gradle task `basex_jobs`.

Also have a look in the BaseX documentation on [Job Functions](https://docs.basex.org/main/Job_Functions)

## How can I configure BaseX options?

Configuration options for BaseX can be specified in the file `src\startup\.basex`.

This version-controlled file `src\startup\.basex` is automatically copied to a non-version-controlled copy `.basex` in the this project's root folder. BaseX updates this configuration file in the project root folder with localized settings (such as absolute file paths) that should not be version controlled, so it is helpful use the version controlled copy for any configuration options that should be retained.

Note that the `.basex` file can be somewhat sensitive to having configuration options placed under the correct # heading. 

Configuration options that are only needed in the development environment can be specified in `gradle.properties`.

BaseX also has configuration files in src/webapp/WEB-INF that can be used to specify configuration options, such as http port. These configuration files are automatically generated if they are not already present, so they do not need to be version controlled unless you add your own configuration to these files. 

To see the effective configuration options run `db:system()` or `INFO` in the BaseX GUI or go to http://localhost/system

See the BaseX documentation on [Options](https://docs.basex.org/main/Options) for more information about the options that are available and other ways to configure options.

## How can I configure an XML Catalog?

The answer to this question depends somewhat on which versions of Java, BaseX, and Saxon you are using. Within `build.gradle` there are some commented-out lines of XML Catalog configuration that provide examples that may work for older or newer versions. The active (not commented-out) configuration has been tested with Java 17, BaseX 11.1, and Saxon 12.4.

`xmlCatalog` in `build.xml` specifies the XML Catalog for XSpec and Saxon.

`CATALOG` in `src\startup\.basex` specifies the XML Catalog for BaseX.

An example XML Catalog and DTD for JATS are included in the `src\schemas` folder.

## How can I run tests automatically?

Run `test.cmd` found in the `bin` folder.

This script runs Gradle task `test`, which in turn runs other Gradle tasks:

`basex_test` runs all XQuery unit tests found in specific folders within the `src` folder. See the BaseX documentation on [Unit Functions](https://docs.basex.org/main/Unit_Functions) for information about the testing framework that BaseX provides.

`xspec_test` runs all XSpec tests that are found.

## How can I run tests automatically using GitHub Actions?

The `.github\workflows\ci-tests.yml` file defines the script for GitHub Actions to run all tests every time a change is pushed to this repository on GitHub.

This script runs the Gradle task `test`.

To see the progress and results of tests go to the [Actions](https://github.com/vincentml/balisage-2024-open-mic/actions) tab in the GitHub project.

## How can I run BaseX using Docker?

For this example you will need to have [Docker Desktop](https://www.docker.com/products/docker-desktop/) already installed and running.

First check that Docker Desktop is running.

Run `docker-up.cmd` found in the `bin` folder.

This script does several things. It runs the Gradle task `stage` which exports everything that needs to be deployed inside a Docker container to the folder `build\basex`. Then it builds and runs a Docker container using the `Dockerfile` script. During this process files are copied to `/srv/basex` within the container. Finally, it launches a web browser pointed to the Docker container (running BaseX) and opens a terminal for running commands inside the Docker container.

When you want to stop the Docker container run `docker-rm.cmd` found in the `bin` folder.

