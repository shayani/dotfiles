# Check if the OS is Arch Linux
if [[ -f /etc/arch-release ]]; then
  echo "Using Arch"
  environment_file="/etc/environment"
else
  environment_file="/etc/environment.d/50-cedilla.conf"
fi

echo "GTK_IM_MODULE=cedilla" > "$environment_file"
echo "QT_IM_MODULE=cedilla" >> "$environment_file"
