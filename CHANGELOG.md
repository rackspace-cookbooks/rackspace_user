rackspace_user Cookbook CHANGELOG
=======================
This file is used to list changes made in each version of the rackspace_user cookbook.

v1.0.0
------
### Improvement
- Rackspace rework
- Added ability to enable sudo for a user without making the sudo access passwordless (see: 'sudo_nopasswd' attribute)
- Removed template override for rackspace_sudo, created pull request for rackspace_sudo to fix the template there
