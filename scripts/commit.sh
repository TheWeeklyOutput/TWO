echo "Please enter the commit message: "
read input_variable


cd backend/

git add *
git commit -a -m "$input_variable"

cd ../frontend/

git add *
git commit -a -m "$input_variable"

cd ..

git add *
git commit -a -m "$input_variable"
