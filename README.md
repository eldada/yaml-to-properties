# NOTICE
**As of `yq` version 4.12, there is a built in [Yaml to Properties](https://mikefarah.gitbook.io/yq/v/v4.x/usage/properties) support.**
It (almost) covers all capabilities of `yaml-to-properties.sh`.

# Yaml to Properties
Convert a YAML formatted file to a flat properties file with a bash script and the [yq](https://github.com/mikefarah/yq) utility<br>
**NOTES:**
* You must have [yq v4](https://github.com/mikefarah/yq/releases) installed!
* You should use a valid yaml formatted file as input

## Usage
```shell script
# Get usage
./yaml-to-properties.sh --help

# Convert all elements in file
./yaml-to-properties.sh --file ./examples/simple.yaml
```

## Examples
### Simple YAML
For the [simple.yaml](examples/simple.yaml) file with the following
```
a:
  key1: "value1"
  key2: 2.6
  ab:
    key1: 6
    key2: "h"
b:
  emptyKey:

```
You get
```shell script
$ ./yaml-to-properties.sh --file ./examples/simple.yaml
a.key1=value1
a.key2=2.6
a.ab.key1=6
a.ab.key2=h
b.emptyKey=

```

### Arrays YAML
For the [arrays.yaml](examples/arrays.yaml) file with the following
```
a:
  array:
    - name: "element1"
      value: "value1"
    - name: "element2"
      value: "value2"
      sub-array:
        - sub1: "x"
        - sub2: "y"
        - sub3: "z"
b:
  emptyArray: []
c:
  emptyMap: {}

```
You get
```shell script
$ ./yaml-to-properties.sh --file ./examples/arrays.yaml
a.array.0.name=element1
a.array.0.value=value1
a.array.1.name=element2
a.array.1.value=value2
a.array.1.sub-array.0.sub1=x
a.array.1.sub-array.1.sub2=y
a.array.1.sub-array.2.sub3=z
b.emptyArray=
c.emptyMap=

```

## Contribute
Contributing is more than welcome with a pull request
