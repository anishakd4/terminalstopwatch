#!/bin/bash


bar_size=$(tput cols)
num1=30
bar_size=$((bar_size - num1)) 
bar_char_done="█"
bar_char_todo="-"
bar_percentage_scale=2

function show_progress {
    current="$1"
    total="$2"

    # calculate the progress in percentage 
    percent=$(bc <<< "scale=$bar_percentage_scale; 100 * $current / $total" )
    # The number of done and todo characters
    done=$(bc <<< "scale=0; $bar_size * $percent / 100" )
    todo=$(bc <<< "scale=0; $bar_size - $done" )

    # build the done and todo sub-bars
    done_sub_bar=$(printf "%${done}s" | tr " " "${bar_char_done}")
    todo_sub_bar=$(printf "%${todo}s" | tr " " "${bar_char_todo}")

    # output the bar
    echo -ne "\rProgress : [${done_sub_bar}${todo_sub_bar}] ${percent}%"

    if [ $total -eq $current ]; then
        echo -e "\nDONE"
    fi
}

tasks_in_total=37

for current_task in $(seq $tasks_in_total) 
    do
    sleep 0.2 #simulate the task running
    show_progress $current_task $tasks_in_total
done

echo "Stopwatch started. Press [CTRL+C] to stop."

# # Record the start time
# start_time=$(date +%s)

# # Infinite loop to update the timer
# while true; do
#     current_time=$(date +%s)
#     elapsed=$((current_time - start_time))

#     printf "\n"

#     echo $elapsed

#     if [[ $elapsed -gt 20 ]]; then
#         echo "Time's up! You took too long."
#         break
#     fi

#     printf "\n"

#     hours=$((elapsed / 3600))
#     minutes=$(((elapsed % 3600) / 60))
#     seconds=$((elapsed % 60))

#     # Clear the screen and print elapsed time
#     printf "\rElapsed Time: %02d:%02d:%02d" "$hours" "$minutes" "$seconds"

#     sleep 1  # Update every second
# done
