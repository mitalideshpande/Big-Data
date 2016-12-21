create table if not exists book_data
(line string
)
partitioned by (book_name string);

LOAD DATA LOCAL INPATH '/home/administrator/books/A mid summer night dream.txt' INTO table book_data partition(book_name='A mid summer night dream.txt');

LOAD DATA LOCAL INPATH '/home/administrator/books/Hamlet.txt' INTO table book_data partition(book_name='Hamlet');

LOAD DATA LOCAL INPATH '/home/administrator/books/King Richard III.txt' INTO table book_data partition(book_name='King Richard III');


LOAD DATA LOCAL INPATH '/home/administrator/books/MacBeth.txt' INTO table book_data partition(book_name='MacBeth');

LOAD DATA LOCAL INPATH '/home/administrator/books/Othello.txt' INTO table book_data partition(book_name='Othello');

LOAD DATA LOCAL INPATH '/home/administrator/books/Romeo and Juliet.txt' INTO table book_data partition(book_name='Romeo and Juliet');

LOAD DATA LOCAL INPATH '/home/administrator/books/The Merchant of Venice.txt' INTO table book_data partition(book_name='The Merchant of Venice');

LOAD DATA LOCAL INPATH '/home/administrator/books/The tempest.txt' INTO table book_data partition(book_name='The tempest');

LOAD DATA LOCAL INPATH '/home/administrator/books/The tragedy of King Lear.txt' INTO table book_data partition(book_name='The tragedy of King Lear');

LOAD DATA LOCAL INPATH '/home/administrator/books/The tragedy of Julius Casear.txt' INTO table book_data partition(book_name='The tragedy of Julius Casear')

select explode(NGRAMS(SENTENCES(LOWER(line)),3,10)) as trigrams from book_data;

create table s_data(data string);

insert overwrite table s_data select explode(NGRAMS(SENTENCES(LOWER(line)),3,10)) as trigrams from book_data;

