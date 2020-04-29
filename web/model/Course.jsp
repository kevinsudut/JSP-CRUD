<%@ include file="../connection/Connect.jsp" %>
<%@page import="java.util.*" %>

<%!
    public class Course {
        /*
         * The connect value from Connect class
         */
        private Connect connect;

        /*
         * Attribute from the class. Adjust to the course table column from the database
         */
        private Integer id;
        private String code;
        private String name;
        private Integer credit;

        public Course() {
            /*
             * Set value with Connect class instance
             */
            this.connect = Connect.getConnection();
        }

        public Course(ResultSet resultSet) {
            /*
             * Set value with Connect class instance
             */
            this.connect = Connect.getConnection();
            
            try {
                
                /*
                 * Fill this Course class attribute with the data from the.
                 * getInt(<column>) -> to get integer value
                 * getString(<column>) -> to get string value
                 * The parameter from getInt() and getString() method base on column name from course table or column order that start from 1..n
                 */
                this.id = resultSet.getInt("id");
                this.code = resultSet.getString("code");
                this.name = resultSet.getString("name");
                this.credit = resultSet.getInt("credit");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        /*
         * Setter and Getter from this class
         */
        public void setId(Integer id) { this.id = id; }
        public Integer getId() { return id; }
        public void setCode(String code) { this.code = code; }
        public String getCode() { return code; }
        public void setName(String name) { this.name = name; }
        public String getName() { return name; }
        public void setCredit(Integer credit) { this.credit = credit; }
        public Integer getCredit() { return credit; }

        /*
         * Method to get all data from the database
         */
        public Vector<Course> get() {
            Vector<Course> courses = new Vector<Course>();
    
            try {
                /*
                 * Query to get all data
                 */
                String query = "SELECT * FROM courses";
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);    
                
                /*
                 * Add all result from the database to the list
                 */
                while (resultSet.next()) {
                    courses.add(new Course(resultSet));        
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            return courses;
        }

        /*
         * Method to get data from the database by id 
         */
        public Course find(Integer id) {
            Course result = null;
    
            try {
                /*
                 * Query to get data by id
                 */
                String query = String.format("SELECT * FROM courses WHERE id = %d LIMIT 1", id);
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);

                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new Course(resultSet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

        /*
         * Method to get data from the database by column name and value 
         */
        public Course exists(String column, String value) {
            Course result = null;
            
            try {
                /*
                 * Query to get data by column name and value
                 */
                String query = String.format("SELECT * FROM courses WHERE %s = '%s' LIMIT 1", column, value);
                
                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);
                
                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new Course(resultSet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return result;    
        }

        /*
         * Method to get last data from the database
         */
        public Course last() {
            Course result = null;
            
            try {
                /*
                 * Query to get data last data
                 */
                String query = "SELECT * FROM courses ORDER BY id DESC LIMIT 1";

                /*
                 * Execute the query
                 */
                ResultSet resultSet = connect.executeQuery(query);            
                
                /*
                 * Set result value to course model
                 */
                if (resultSet.next()) {
                    result = new Course(resultSet);
                } 
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

        /*
         * Method to insert data to the database
         */
        public Course insert() {
            try {
                /*
                 * Query to insert data
                 */
                String query = String.format("INSERT INTO courses (code, name, credit) VALUES ('%s', '%s', %d)", code, name, credit);
                
                /*
                 * Execute the query
                 */
                connect.executeUpdate(query);
            } catch (Exception e) {
                e.printStackTrace();
            }

            /*
             * Return last inserted data
             */
            return last();
        }

        /*
         * Method to update data from the database
         */
        public Course update() {
            try {
                /*
                 * Query to update data
                 */
                String query = String.format("UPDATE courses SET code = '%s', name = '%s', credit = %d WHERE id = %d", code, name, credit, id);
                
                /*
                 * Execute the query
                 */
                connect.executeUpdate(query);
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            return this;
        }

        /*
         * Method to delete data from the database by id
         */
        public Boolean delete(Integer id) {
            Integer affected = 0;
            try {
                /*
                 * Query to delete data
                 */
                String query = String.format("DELETE FROM courses WHERE id = %d", id);

                /*
                 * Execute the query
                 */
                affected = connect.executeUpdate(query);
            } catch (Exception e) {
                e.printStackTrace();
            }

            return affected > 0;
        }
    }
%>
