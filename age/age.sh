#!/bin/bash

# Get current date details
current_year=$(date +%Y)
current_month=$(date +%m)
current_day=$(date +%d)

echo "Enter your birth date (e.g., 1995 5 7 or 1995 0521):"
read -a input

b_year=${input[0]}
remaining=${input[1]}

# --- Smart parsing logic ---
if [ ${#remaining} -eq 1 ]; then
    b_month=$remaining
    b_day=1
elif [ ${#remaining} -eq 2 ]; then
    if [[ "$remaining" =~ ^(10|11|12)$ ]]; then
        b_month=$remaining
        b_day=1
    else
        b_month=${remaining:0:1}
        b_day=${remaining:1:1}
    fi
elif [ ${#remaining} -eq 3 ]; then
    if [[ "${remaining:0:2}" =~ ^(10|11|12)$ ]]; then
        b_month=${remaining:0:2}
        b_day=${remaining:2:1}
    else
        b_month=${remaining:0:1}
        b_day=${remaining:1:2}
    fi
elif [ ${#remaining} -eq 4 ]; then
    b_month=${remaining:0:2}
    b_day=${remaining:2:2}
else
    b_month=${input[1]}
    b_day=${input[2]:-1}
fi

# Remove leading zeros
b_month=$((10#$b_month))
b_day=$((10#$b_day))

# --- 1. Calculate EXACT Current Age ---
age_years=$((current_year - b_year))
age_months=$((current_month - b_month))
age_days=$((current_day - b_day))

if [ $age_days -lt 0 ]; then
    age_months=$((age_months - 1))
    age_days=$((age_days + 30))
fi

if [ $age_months -lt 0 ]; then
    age_years=$((age_years - 1))
    age_months=$((age_months + 12))
fi

# --- 2. Calculate Countdown to Next Birthday ---
rem_months=$((b_month - current_month))
rem_days=$((b_day - current_day))

if [ $rem_days -lt 0 ]; then
    rem_months=$((rem_months - 1))
    rem_days=$((rem_days + 30))
fi

if [ $rem_months -lt 0 ]; then
    rem_months=$((rem_months + 12))
fi

# 3. Display the results
echo -e "\n------------------------------------"
echo " "
echo "Your Birthday Date: $b_year-$(printf "%02d" $b_month)-$(printf "%02d" $b_day)"
echo "🎂 Your current age is: $age_years years old"
echo " "
echo "------------------------------------"
echo " "
echo "🎂 Exactly age is:"
echo "   $age_years Years, $age_months Months, and $age_days Days"
echo " "
echo "------------------------------------"


if [ $current_month -eq $b_month ] && [ $current_day -eq $b_day ]; then
    echo "🎉 Happy Birthday! Today is your special day!"
else
    echo "📅 Remaining until your next birthday:"
    echo "   $rem_months months and $rem_days days."
fi
echo "------------------------------------"
