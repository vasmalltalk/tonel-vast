<p align="center">
 <h1 align="center">Tonel for VAST Platform (VA Smalltalk)</h1>
  <p align="center">
    Providing a git friendly file format support to VA Smalltalk
    <!---
    <br>
    <a href="docs/"><strong>Explore the docs »</strong></a>
    <br>
    -->
    <br>
    <a href="https://github.com/instantiations/tonel-vast/issues/new?labels=Type%3A+Defect">Report a defect</a>
    |
    <a href="https://github.com/instantiations/tonel-vast/issues/new?labels=Type%3A+Feature">Request feature</a>
  </p>
</p>



## Introduction

For [Instantiations](https://www.instantiations.com/) and VA Smalltalk, having git support is a priority. The first step is to have a plain text file-based output and input for the sources of its Applications.

[Tonel](https://github.com/pharo-vcs/tonel) is the current file format widely accepted by the Smalltalk community to store source code on disk with a VCS-friendly format.

With that present we implemented support for the [Tonel format](https://github.com/pharo-vcs/tonel) in VAST 9.2.x. Our implementation complies with the specification of the format. But since the specification does not take into account some important VAST specific features we extended it in a non intrusive way to make it compatible with the spec and useful to VAST users as well.

If you want to see real projects using Tonel for VAST you can see them at the [VAST Community Hub](/vast-community-hub) or in the [Instantiations](/instantiations) repositories.

## License
- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).


## Installation

### Installing in VAST 2021

Starting with VAST 2021 (10.0.0) Tonel comes as a Feature inside the product. That means it can be easily installed from the `Transcript` -> `Load/Unload Features...`. You will find two features you can install: `ST: Tonel Support` and `ST:Tonel Support, Testing`.


### Installing the development version in VAST 2021

We continue to improve the Tonel support by fixing bugs and adding new features to it, if you want to use the lastest version you can do it by downloading the latest version in this repository into the latest version of VAST 2021 (currently 10.0.1).

- Load Tonel VAST Features using `Transcript` -> `Load/Unload Features...`. There you will find two features you can install: `ST: Tonel Support` and `ST:Tonel Support, Testing`.
- Open Configurations Maps Browser
- Clone this repository locally using your preferred git tool.
- Right click in the `All names` list, select `Import` -> `Load Configuration Maps from Tonel repository...`
- Select the `.project` file of the directory you cloned in the step above
- Select `ENVY/Image Tonel` and/or `Test ENVY/Image Tonel`


### Installing in VAST 9.2.x

- Clone this repository locally
- [Download VAST](https://www.instantiations.com/products/vasmalltalk/download.html) from Instantiations website.
  - If you're using 9.2.1 checkout the [v1.1.0 tag](https://github.com/instantiations/tonel-vast/releases/tag/v1.1.0)
  - If you're using 9.2.2 checkout the [v1.2.0 tag](https://github.com/instantiations/tonel-vast/releases/tag/v1.2.0)
- From the Configuration Map Browser, do an `Import` -> `All Most Recent Versions...` -> and select the `envy/Tonel.dat` located in the root folder of your local repository clone.
- Select the map `Tonel` (and optionally `Test Tonel` if you want to run its SUnit tests) and do a `Load With Required Maps` the latest version of it.
- Optionally run the SUnit tests included in the map `Test Tonel` to ensure correct installation. One easy way is to right-click on the `Test Tonel` map name in the Name pane (as opposed to version pane ) and then select `Test Loaded Applications`.
- Explore the [documentation](docs/).

## Quick Start

### Using GUI menus

#### Applications

You can load individual Tonel packages as Applications or export VAST Applications as Tonel packages via Application Manager's `Import/Export`.

![Application Manager](docs/img/application-manager.png)

When loading apps using this GUI the _loader_ will attempt to detect whether the files are in a Git repository, and if a git repository is detected it will configure itself to use [git versioning](docs/strategies.md), otherwise it will use the default settings (or leave all editions open without version).

#### Configuration Maps

You can also export and load Configuration Maps together with their applications from the Configuration Maps Browser.

##### Exporting

Select the Configuration Maps you want to export in the names list, and then open the contextual menu and choose `Export`, and then `Export Configuration Maps to Tonel`.

![Configuration Maps Export](docs/img/configmaps-export.png)

This will ask you which version of the config maps you want to export (only one version per map is allowed), where do you want to store it, as well as a few other settings.

##### Loading

To load a Configuration Map in a Tonel repository into VAST, you have to choose the `Import` option in the names list, and then `Load Configuration Maps from Tonel...`.

![Configuration Maps Load](docs/img/configmaps-load.png)

Once you select the available Configuration Maps, they will be loaded together with their required maps. If a required map is within the Tonel repository, then this map version will take precedence over the version specified.


### Programmatically

As with the GUI options, you can also export independent Applications or whole Configuration Maps to Tonel.

#### Applications

```smalltalk
"Exporting to Tonel"
TonelWriter new
  clearSourcesDirectory; "deletes everything in the target directory"
  writeProjectIncluding: (Array with: MyAppCore)
  into: (CfsPath named: 'my-tonel-demos').
 ```

```smalltalk
"Loading from Tonel"
(TonelLoader readFromPath (CfsPath named: 'my-tonel-demos'))
  loadApplicationNamed: 'MyAppCore'.

"or you can load by Tonel package name"
(TonelLoader readFromPath (CfsPath named: 'my-tonel-demos'))
  loadApplicationsForPackagesNamed: #('MyApp-Core' 'MyApp-Tests').
```

#### Configuration Maps

```smalltalk
"Exporting to Tonel"
TonelWriter new
  addLatestConfigurationMapNamed: 'My Tonel Demo';
  addLatestConfigurationMapNamed: 'My Tonel Demo Tests';
  addApplicationsFromConfigurationMaps;
  writeProjectInto: (CfsPath named: 'my-tonel-demos').
```
```smalltalk
"Loading from Tonel"
(TonelLoader readFromPath: (CfsPath named: 'my-tonel-demos')) loadAllMapsWithRequiredMaps.
```

#### More options

You can specify other options like versioning, prerequisite resolution, and others using the different strategies for each case, read the [strategies documentation](docs/strategies.md) to learn more about them.


## VAST Specific features

Since Tonel wasn't designed with VAST use in mind, some features are not supported by the spec and we needed to extend it to support them.

You can read [document of VAST specific features](docs/vastspecific.md) to know more about them.

## Compatibility Recommendations

If you want to make your code fully compatible and interoperable with other Smalltalk dialects there is a specific document with the [recommendations for compatibility](docs/compatibility.md).

## Shared Pools

VAST's way of declaring and/or initializing Shared Pools is different from other Smalltalk dialects, and to explain how this work with Tonel, there is a specific document explaining [how VAST Tonel handles shared pools](docs/sharedpools.md).


## Versioning and prerequisites

Read the [versioning, prerequisites and base editions strategies documentation](docs/strategies.md) to learn how to configure the loader to work interactively, unattended, read the version from a git repository, etc.

## Configuration Maps

Although dependency management is outside of the scope of Tonel, VAST Platform's Tonel tools provide a way to write them to disk and later read and load them.

Read the [Configuration Maps documentation](docs/configmaps.md) to learn how to use it.

## Architecture

There are four main building blocks that work in layers to support Tonel in VAST Platform:

### Tonel Parser
Parses the Tonel specific files following the same rules as the [canonical version](https://github.com/pharo-vcs/tonel).

### Tonel Reader
Relies on the parser to create first-class objects representing each abstraction from Tonel. E.g. _Package_, _Class_, _Method Definition_, _Method Extension_

### Tonel Loader
Uses the reader to compile classes, methods, extensions, etc. and then create the required editions and versions in the ENVY Library.

### Tonel Writer
Writes to disk, in a Tonel compatible format (plus the VAST specific features described below) the Applications, SubApplications, Classes, Shared Pools, Methods, Extensions, etc.

If the Application has a class side `#tonelPackageName` selector it  will then honor it when creating the package name.


## Testing

The Reader, Parser and Writer tests can be run out of the box once loaded, but the Loader tests need a little setup in order to run.

Once you clone this repository you have to configure `TonelLoaderTest` to point to the `tests` directory within the repository, since it contains the repositories used for testing the loader.

```smalltalk
TonelLoaderTest testRepositoriesPath: (CfsPath named: 'repo-path\tests')
```

### Note about side-effects

The Loader tests will attempt to leave the ENVY Library (aka "the library") in the same logical state as it was before running them by means of reloading the applications that were loaded before starting and purging newly created editions, but since this can the access to the library isn't atomic (as in a single enclosing transaction) there could be leftovers if something goes wrong. So it isn't adviced to run the tests against your production library.


## Versioning of this very project

The versioning of this particular project is a little tricky because there are serveral versions going on in parallel: the version that comes with the VAST release, the config map version of each commit, and release version of Github releases. Because of that, the versioning strategy has been changing since the beginning of the project, looking for the optimal one. 

Starting with VAST 10.0.0 we decided to adopt a versioning strategy that might eliminate the multiple version naming, and help in mapping the different versions together.

Guidelines:
* The `Tonel Support` feature (and/or its Test variant)  must be loaded before loading this project into a VAST image
* The `ENVY/Image Tonel` version that comes as a feature in a VAST release (currently v 10.0.0 [480]) is considered the "trunk"
* The code from this repository is loaded on top of the configurations maps loaded in the previous points
* When versioning configuration maps both the "trunk" version identifier and a sequential version will be used as the version name, e.g. `v 10.0.0  [v1.3.6]`.
* Once a new Github release is published, the `v1.3.6` part above will likely be re-published as `v1.4.0` (the version of the release).
* When there is a VAST release that integrates one of the Github releases as a built-in _feature_, it will rename `v 10.0.1  [v1.4.0]` to something like `v 10.0.2  [543]` (being the `543` the VAST build number), but both versions will likely share the same internal timestamp.

## Roadmap / Next steps

See the [roadmap document](docs/roadmap.md) for further details.


## Acknowledgments

- [Mercap Software](https://github.com/Mercap) for their first draft on the Tonel writer
- Github repository layout was generated with [Ba-St Github-setup project](https://github.com/ba-st/GitHub-setup).

## Contributing

Check the [Contribution Guidelines](docs/CONTRIBUTING.md)
