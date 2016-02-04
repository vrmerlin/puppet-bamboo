## 2016-02-04 - Release 3.2.1

### Summary

- Provide param to disable managing the 'installdir' (@Etherdaemon PR #4)
- Provide param to disable managing the 'appdir' (@Etherdaemon PR #4)
- Provide param to specify a custom 'appdir' (@Etherdaemon PR #4)

## 2015-11-17 - Release 3.1.2

### Summary

- Bump default Bamboo version to 5.9.7 from 5.9.4 (@tarrantmarshall PR #3)
- Specify catalina pid file in setenv.sh (@tarrantmarshall PR #3)

## 2015-10-09 - Release 3.1.1

### Summary

- Documentation added
- Expanded unit testing
- Manage home directory even if user isn't managed

## 2015-10-08 - Release 3.1.0

### Summary

- Improvements to init script
  - Better status and stop handling - check process table and wait for
    process shutdown
  - Remove lockfile - check process table

## 2015-10-07 - Release 3.0.0

### Summary

- Forked module from dormant upstream and significant refactoring
- Abstract functionality into separate classes
- Add more customization options, including the ability to manage various
  Bamboo configuration settings (Tomcat)
- Abandon support for older versions of Bamboo

## Release 2.0.0

- Works with Bamboo 4.4+

## Release 1.0.0

- Works with Bamboo up to 4.4
