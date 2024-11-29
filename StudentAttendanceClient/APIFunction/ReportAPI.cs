using BusinessObjects.DTO.AttendanceDTO;
using BusinessObjects.DTO.ReportDTO;
using BusinessObjects.DTO.ScheduleDTO;

namespace StudentAttendanceClient.APIFunction
{
    public class ReportAPI
    {
        private static readonly HttpClient client = new HttpClient();

      

        public static async Task<List<ClassSchedule>> GetClassBySemester(int studentId, int semesterId)
        {
            string url = $"http://localhost:5019/api/Report/GetClassBySemester/{studentId}/{semesterId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    var jsonResponse = await response.Content.ReadAsStringAsync();
                    Console.WriteLine("Response Content: " + jsonResponse); // Log nội dung phản hồi

                    // Đọc dữ liệu JSON và chuyển đổi sang danh sách ClassSchedule
                    return await response.Content.ReadFromJsonAsync<List<ClassSchedule>>();
                }
                else
                {
                    // Log hoặc xử lý lỗi từ API
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<ClassSchedule>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log lỗi HTTP request
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<ClassSchedule>();
            }

        }
        public static async Task<List<CourseClass>> GetClassBySemesterAndCourse(int teacherId, int semesterId,int courseId)
        {
            string url = $"http://localhost:5019/api/Report/GetClassBySemesterAndCourse/{teacherId}/{semesterId}/{courseId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    var jsonResponse = await response.Content.ReadAsStringAsync();
                    Console.WriteLine("Response Content: " + jsonResponse); // Log nội dung phản hồi

                    // Đọc dữ liệu JSON và chuyển đổi sang danh sách ClassSchedule
                    return await response.Content.ReadFromJsonAsync<List<CourseClass>>();
                }
                else
                {
                    // Log hoặc xử lý lỗi từ API
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<CourseClass>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log lỗi HTTP request
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<CourseClass>();
            }

        }
        public static async Task<List<CourseClass>> GetCoursesBySemester(int teacherId, int semesterId)
        {
            string url = $"http://localhost:5019/api/Report/GetCoursesBySemester/{teacherId}/{semesterId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    var jsonResponse = await response.Content.ReadAsStringAsync();
                    Console.WriteLine("Response Content: " + jsonResponse); // Log nội dung phản hồi

                    // Đọc dữ liệu JSON và chuyển đổi sang danh sách ClassSchedule
                    return await response.Content.ReadFromJsonAsync<List<CourseClass>>();
                }
                else
                {
                    // Log hoặc xử lý lỗi từ API
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<CourseClass>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log lỗi HTTP request
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<CourseClass>();
            }

        }
        public static async Task<List<ClassSchedule>> GetClassScheduleAPI(int studentId, int semesterId,int courseId)
        {
            string url = $"http://localhost:5019/api/Report/GetClassSchedule/{studentId}/{semesterId}/{courseId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    var jsonResponse = await response.Content.ReadAsStringAsync();
                    Console.WriteLine("Response Content: " + jsonResponse); // Log nội dung phản hồi

                    // Đọc dữ liệu JSON và chuyển đổi sang danh sách ClassSchedule
                    return await response.Content.ReadFromJsonAsync<List<ClassSchedule>>();
                }
                else
                {
                    // Log hoặc xử lý lỗi từ API
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<ClassSchedule>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log lỗi HTTP request
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<ClassSchedule>();
            }

        }


        public static async Task<List<ClassSchedule>> GetStudentSchedule(int studentId)
        {
            string url = $"http://localhost:5019/api/Report/GetStudentSchedule/{studentId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    var jsonResponse = await response.Content.ReadAsStringAsync();
                    Console.WriteLine("Response Content: " + jsonResponse); // Log nội dung phản hồi

                    // Đọc dữ liệu JSON và chuyển đổi sang danh sách ClassSchedule
                    return await response.Content.ReadFromJsonAsync<List<ClassSchedule>>();
                }
                else
                {
                    // Log hoặc xử lý lỗi từ API
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<ClassSchedule>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log lỗi HTTP request
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<ClassSchedule>();
            }

        }

        public static async Task<int> CallGetCourseIdBySemester(int studentId, int semesterId)
            {
                string url = $"http://localhost:5019/api/Report/GetCourseIdBySemester/{studentId}/{semesterId}"; // Thay đổi URL cho phù hợp
                try
                {
                    HttpResponseMessage response = await client.GetAsync(url);
                    if (response.IsSuccessStatusCode)
                    {
                        // Đọc dữ liệu JSON và trả về CourseId
                        return await response.Content.ReadFromJsonAsync<int>();
                    }
                    else
                    {
                        // Log hoặc xử lý lỗi từ API
                        Console.WriteLine("API Error: " + response.ReasonPhrase);
                        return 0; // Trả về giá trị mặc định nếu có lỗi
                    }
                }
                catch (HttpRequestException ex)
                {
                    // Log lỗi HTTP request
                    Console.WriteLine("HTTP Request Error: " + ex.Message);
                    return 0; // Trả về giá trị mặc định nếu có lỗi
                }
            }


        public static async Task<List<ViewAllAttendanceStudentDTO>> GetAllStudentByTeacherAndCourseAndClass(int teacherId, int semesterId, int courseId, int classId)
        {
            string url = $"http://localhost:5019/api/Report/GetAllStudentByTeacherAndCourseAndClass/{teacherId}/{semesterId}/{courseId}/{classId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<ViewAllAttendanceStudentDTO>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<ViewAllAttendanceStudentDTO>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<ViewAllAttendanceStudentDTO>();
            }
        }


        public static async Task<List<ViewAllAttendanceStudentDTO>> GetAllAttendanceStudentByDate(int teacherId, int semesterId, int courseId, int classId)
        {
            string url = $"http://localhost:5019/api/Report/GetAllAttendanceStudentByDate/{teacherId}/{semesterId}/{courseId}/{classId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<ViewAllAttendanceStudentDTO>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<ViewAllAttendanceStudentDTO>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<ViewAllAttendanceStudentDTO>();
            }
        }
        public static async Task<List<ViewAllAttendanceStudentDTO>> GetAllAttendanceByTeacherAndCourseAndClass(int teacherId, int semesterId, int courseId, int classId)
        {
            string url = $"http://localhost:5019/api/Report/GetAllAttendanceByTeacherAndCourseAndClass/{teacherId}/{semesterId}/{courseId}/{classId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<ViewAllAttendanceStudentDTO>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<ViewAllAttendanceStudentDTO>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<ViewAllAttendanceStudentDTO>();
            }
        }


    }
}
