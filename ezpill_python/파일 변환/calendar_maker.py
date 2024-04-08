
for i in range(1,13):
    for j in range(1,32):
        if i==2:
            if j>29:
                break
        if i==4 or i==6 or i==9 or i==11:
            if j>30:
                break
        print(f'DateTime.utc(2024, {i}, {j}): [Event(\'title\')],');

