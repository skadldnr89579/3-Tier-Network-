import pymysql
conn = pymysql.connect(host='[rds endpoint]', user='admin', password='[password set rds.tf]', db='status_db')
cur = conn.cursor()
cur.execute('DELETE FROM user_status_logs')
conn.commit()
print('Successfully Deleted!')
conn.close()