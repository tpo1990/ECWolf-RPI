#!/usr/bin/env bash

# -- find .pk3 file -- #
pk3="$(ls *.pk3)"

# -- read user input for filename change -- #
echo What should we call the mod?
read filename
echo renamed mod to $filename

# -- create .ecwolf file from users input -- #
cat > "$filename.ecwolf" << EOF
cd "."
"/opt/retropie/ports/ecwolf/ecwolf" --data WL6 --file $pk3
wait $!
EOF

# -- move .pk3 file into wolf3d roms folder -- #
mv "$pk3" "$HOME/RetroPie/roms/ports/wolf3d"

# -- move .ecwolf file into wolf3d roms folder -- #
mv "$filename.ecwolf" "$HOME/RetroPie/roms/ports/wolf3d"

# -- create runcommand.sh file from users input -- #
cat > "$filename.sh" << EOF
#!/bin/bash
"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "ecwolf" "$HOME/RetroPie/roms/ports/wolf3d/$filename.ecwolf"
EOF

# -- move runcommand.sh file into ports folder -- #
mv "$filename.sh" "$HOME/RetroPie/roms/ports/$filename.sh"

# -- installation message -- #
echo "$filename mod installed for ECWolf. Press enter button to continue."

read
# -- end --#