
# Add and push sub module
git submodule add https://github.com/issus/altium-library.git
git add .gitmodules altium-library
git commit -m "Added submodule of another person's repo"
git push origin main
# Pull the submodule updates when you pull your repo
git submodule update --remote --merge
git pull --recurse-submodules
