# Third-Party Licenses

This project builds and distributes container images that include components from upstream projects.

## Included Upstream Projects

### linuxserver/webtop
- Upstream: https://github.com/linuxserver/docker-webtop
- License: GNU General Public License v3.0 (GPL-3.0)
- Local copy: `LICENSES/GPL-3.0-webtop.txt`
- Usage in this project: Base image for `Dockerfiles/webtop-openclaw/Dockerfile`

### openclaw/openclaw
- Upstream: https://github.com/openclaw/openclaw
- License: MIT
- Local copy: `LICENSES/MIT-openclaw.txt`
- Usage in this project: Installed in image build step

## Source Availability Notes

For transparency and compliance:
- This repository includes Dockerfiles and build scripts used to produce published images.
- Upstream source code remains available at the links above.
- If image tags are published, corresponding build inputs should remain available in this repository history.

## Disclaimer

This file is for practical engineering compliance and attribution. It is not legal advice.
