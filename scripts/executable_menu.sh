#!/usr/bin/env bash

# Gera um menu com o Walker
menu() {
  local prompt="$1"
  local options="$2"
  local extra="$3"
  local preselect="$4"

  read -r -a args <<<"$extra"

  if [[ -n "$preselect" ]]; then
    local index
    index=$(echo -e "$options" | grep -nxF "$preselect" | cut -d: -f1)
    if [[ -n "$index" ]]; then
      args+=("-a" "$index")
    fi
  fi

  echo -e "$options" | walker --dmenu -p "$prompt…" "${args[@]}"
}

show_screenshot_menu() {
  case "$(menu "Screenshot" "󰸨  Area")" in
    *Area*) ~/scripts/screenshot.sh ;;
  esac
}

show_system_menu() {
	case "$(menu "System" "  Lock\n󰤄  Suspend\n  Kill\n󰜉  Reboot\n󰐥  Shutdown")" in
		*Lock*) pidof hyprlock || hyprlock ;;
		*Suspend*) systemctl suspend ;;
		*Kill*) ps -u $USER -o pid,comm,%cpu,%mem | walker --dmenu -p Kill: | awk '{print $1}' | xargs -r kill ;;
		*Reboot*) systemctl reboot ;;
		*Shutdown*) systemctl poweroff ;;
		*) show_main_menu ;;
	esac
}

show_todoist_menu() {
  case "$(menu "Todoist" "󰒻  Adicionar\n󰒼  Hoje")" in
    *Adicionar*) new_todoist_task;;
    *Hoje*) show_todoist_tasks ;;
  esac
}

new_todoist_task() {
  task="$(echo "" | dmenu -b -p "Nova tarefa: " <&-)" || exit 0
  echo "$task"

  /usr/bin/todoist q "$task" &

  notify-send "Nova tarefa adicionada: $task"
}

show_todoist_tasks() {
  tasks=$(/usr/bin/todoist list -f today | cut -d' ' -f7- | sort)
  echo "$tasks" | walker --dmenu -p "Tarefas para hoje"
}

show_main_menu() {
  # go_to_menu "$(menu "Go" "󰀻  Apps\n󰧑  Learn\n  Capture\n󰔎  Toggle\n  Style\n  Setup\n󰉉  Install\n󰭌  Remove\n  Update\n  About\n  System")"
  go_to_menu "$(menu "Go" "  Todoist\n󰸨  Screenshot\n󰔎  Alterar modo\n  System")"
}

go_to_menu() {
  case "${1,,}" in
  *apps*) walker -p "Launch…" ;; 
  *learn*) show_learn_menu ;; 
  *style*) show_style_menu ;; 
  *theme*) show_theme_menu ;; 
  *capture*) show_capture_menu ;; 
  *screenshot*) show_screenshot_menu ;; 
  *screenrecord*) show_screenrecord_menu ;; 
  *toggle*) show_toggle_menu ;; 
  *setup*) show_setup_menu ;; 
  *install*) show_install_menu ;; 
  *remove*) show_remove_menu ;; 
  *update*) show_update_menu ;; 
  *system*) show_system_menu ;; 
  *todoist*) show_todoist_menu ;; 
  *modo*) /home/shayani/scripts/toggle_theme.sh ;; 
  *about*) gtk-launch About.desktop ;; 
  esac
}

if [[ -n "$1" ]]; then
  go_to_menu "$1"
else
  show_main_menu
fi
