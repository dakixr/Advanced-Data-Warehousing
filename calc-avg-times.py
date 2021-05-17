
file = open('times.txt', 'r')
total = 0
count = 0

for line in file:
    count += 1
    total = total + float(line.strip())
 
print(total/count)
file.close()