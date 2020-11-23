./bimbo.out < $1 > out.c
if [ -z $2 ]
then
	gcc -w out.c linkedList.c integerLinkedList.c -o $2
else
	gcc -w out.c linkedList.c integerLinkedList.c
fi