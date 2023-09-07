#!/bin/bash

# Variables for connecting to the database
# Change the host if it is different from the one you are going to use
DB_HOST='localhost'
# Change the port if it is different from yours
DB_PORT='5432'
# Change the name of the DB if it is different from yours
DB_NAME='steam_academy_db'
# Change the user if it is different from the one you are using
DB_USER='postgres'

# The menu function contains the options
menu() {
	echo -e 'Choose the number of the table to which you want to enter the records\n'
	echo -e '  1) coach\n  2) course\n  3) coach_course\n  4) attendant\n  5) student\n  6) student_course\n  7) Exit\n'
}

# Function for the table coach
insertCoach() {
	echo -e 'You are going to enter records in the coach table\n'

	# Query variables
	echo -n '  dni: '
	read dni
	echo -n '  name: '
	read name
	echo -n '  last name: '
	read last_name
	echo -n '  Stack(Enter your stack of technologies and tools): '
	read stack
	echo -n '  birthday(format YYYY-MM-DD): '
	read birthday
	echo -n '  cellphone: '
	read cellphone_string_abc
	echo -n '  entry date(format YYYY-MM-DD): '
	read entry_date
	echo -n '  departure date(format YYYY-MM-DD): '
	read departure_date
	echo ''

	# Transform the variable of the cellphone from string to numbers
	cellphone_string=$(expr $cellphone_string_abc + 0)
	# Non-numeric characters are extracted if the variable contains them
	cellphone=$(echo "$cellphone_string" | sed 's/[^0-9]*//g')

	# SQL query with INSERT INTO
	coachQuery="INSERT INTO coach(dni, name, last_name, stack, birthday, cellphone, entry_date, departure_date) VALUES ('"${dni}"', '"${name}"', '"${last_name}"', '"${stack}"', '"${birthday}"', "${cellphone}",'"${entry_date}"','"${departure_date}"');"

	# The query is executed
	psql -h ${DB_HOST} -p ${DB_PORT} -d ${DB_NAME} -U ${DB_USER} -c "$coachQuery"

	# The user is told that everything went well
	echo 'Successful Query'
	# The query is shown
	echo -e '\n'${coachQuery}'\n'
}

# Function for the table course
insertCourse() {
	echo -e 'You are going to enter records in the course table\n'

	# Query variables
	echo -n '  name: '
	read name
	echo -n '  description: '
	read description
	echo -n '  syllabus(Enter the syllabus of the course): '
	read syllabus
	echo -n '  duration: '
	read duration
	echo -n '  price(use only numbers and dots): '
	read price_string_abc
	echo ''

	# Non-numeric characters are extracted if the variable contains them
	price_string=$(echo $price_string_abc | sed 's/[a-zA-Z]\$//g')
	# Transform the variable of the price from string to numbers
	price=$(awk "BEGIN {print $price_string}")

	# SQL query with INSERT INTO
	courseQuery="INSERT INTO course(name, description, syllabus, duration, price) VALUES ('"${name}"', '"${description}"', '"${syllabus}"', '"${duration}"', '$"${price}"');"

	# The query is executed
	psql -h ${DB_HOST} -p ${DB_PORT} -d ${DB_NAME} -U ${DB_USER} -c "$courseQuery"

	# The user is told that everything went well
	echo 'Successful Query'
	# The query is shown
	echo -e ${courseQuery}'\n'
}

# Function for the table coach_course
insertCoach_course() {
	echo -e 'You are going to enter records in the coach_course table\n'

	# Query variables
	echo -n '  course id(only numbers): '
	read course_id
	echo -n '  coach dni(up to 15 characters): '
	read coach_dni
	echo ''

	# Transform the variable course_id from string to numbers
	course_id=$(expr $course_id + 0)

	# SQL query with INSERT INTO
	coach_courseQuery="INSERT INTO coach_course(course_id, coach_dni) VALUES ("${course_id}", '"${coach_dni}"');"

	# The query is executed
	psql -h ${DB_HOST} -p ${DB_PORT} -d ${DB_NAME} -U ${DB_USER} -c "$coach_courseQuery"

	# The user is told that everything went well
	echo 'Successful Query'
	# The query is shown
	echo -e '\n'${coach_courseQuery}'\n'
}

# Function for the table attendant
insertAttendant() {
	echo -e 'You are going to enter records in the attendant table\n'

	# Query variables
	echo -n '  cc(up to 15 characters): '
	read cc
	echo -n '  full name(up to 100 characters): '
	read full_name
	echo -n '  cellphone: '
	read cellphone_string_abc
	echo ''

	# Transform the variable of the cellphone from string to numbers
	cellphone_string=$(expr $cellphone_string_abc + 0)
	# Non-numeric characters are extracted if the variable contains them
	cellphone=$(echo "$cellphone_string" | sed 's/[^0-9]*//g')

	# SQL query with INSERT INTO
	attendantQuery="INSERT INTO attendant(cc, full_name, cellphone) VALUES ('"${cc}"', '"${full_name}"', "${cellphone}");"

	# The query is executed
	psql -h ${DB_HOST} -p ${DB_PORT} -d ${DB_NAME} -U ${DB_USER} -c "$attendantQuery"

	# The user is told that everything went well
	echo 'Successful Query'
	# The query is shown
	echo -e '\n'${attendantQuery}'\n'
}

# Function for the table student
insertStudent() {
	echo -e 'You are going to enter records in the student table\n'

	# Query variables
	echo -n '  dni: '
	read dni
	echo -n '  first name: '
	read first_name
	echo -n '  last name: '
	read last_name
	echo -n '  cellphone: '
	read cellphone_string_abc
	echo -n '  birthday(format YYYY-MM-DD): '
	read birthday
	echo -n '  entry date(format YYYY-MM-DD): '
	read entry_date
	echo -n '  departure date(format YYYY-MM-DD): '
	read departure_date
	echo -n '  attendant cc(up to 15 characters): '
	read attendant_cc
	echo ''

	# Transform the variable of the cellphone from string to numbers
	cellphone_string=$(expr $cellphone_string_abc + 0)
	# Non-numeric characters are extracted if the variable contains them
	cellphone=$(echo "$cellphone_string" | sed 's/[^0-9]*//g')

	# SQL query with INSERT INTO
	studentQuery="INSERT INTO student(dni, first_name, last_name, cellphone, birthday, entry_date, departure_date, attendant_cc) VALUES ('"${dni}"', '"${first_name}"', '"${last_name}"', "${cellphone}", '"${birthday}"', '"${entry_date}"', '"${departure_date}"', '"${attendant_cc}"');"

	# The query is executed
	psql -h ${DB_HOST} -p ${DB_PORT} -d ${DB_NAME} -U ${DB_USER} -c "$studentQuery"

	# The user is told that everything went well
	echo 'Successful Query'
	# The query is shown
	echo -e '\n'${studentQuery}'\n'
}

# Function for the table student_course
insertStudent_course() {
	echo -e 'You are going to enter records in the student_course table\n'

	# Query variables
	echo -n '  student dni(up to 15 characters): '
	read student_dni
	echo -n '  course id(only numbers): '
	read course_id
	echo ''

	# Transform the variable course_id from string to numbers
	course_id=$(expr $course_id + 0)

	# SQL query with INSERT INTO
	student_courseQuery="INSERT INTO student_course(student_dni, course_id) VALUES ("${student_dni}", "${course_id}");"

	# The query is executed
	psql -h ${DB_HOST} -p ${DB_PORT} -d ${DB_NAME} -U ${DB_USER} -c "$student_courseQuery"

	# The user is told that everything went well
	echo 'Successful Query'
	# The query is shown
	echo -e '\n'${student_courseQuery}'\n'
}

# We ask the user to which table they want to enter the records
echo -e 'Choose the number of the table to which you want to enter the records\n'
tables=("coach" "course" "coach_course" "attendant" "student" "student_course" "Exit record entry")
select table in "${tables[@]}"; do
	case $table in
	"coach")
		# Call the function insertCoach
		insertCoach

		# The menu is shown
		menu
		;;

	"course")
		# Call the function insertCourse
		insertCourse

		# The menu is shown
		menu
		;;

	"coach_course")
		# Call the function insertCoach_course
		insertCoach_course

		# The menu is shown
		menu
		;;

	"attendant")
		# Call the function insertAttendant
		insertAttendant

		# The menu is shown
		menu
		;;

	"student")
		# Call the function insertStudent
		insertStudent

		# The menu is shown
		menu
		;;

	"student_course")
		# Call the function insertStudent_course
		insertStudent_course

		# The menu is shown
		menu
		;;

	"Exit record entry")
		clear
		echo -e '\n\n  Until next time ;)'
		break
		;;

	*)
		echo "Invalid option $REPLY"
		echo "Try again"
		menu
		;;
	esac
done
