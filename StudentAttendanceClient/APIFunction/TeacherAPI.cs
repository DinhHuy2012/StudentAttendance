using BusinessObjects.DTO;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;

namespace StudentAttendanceClient.APIFunction
{
    public class TeacherAPI
    {
        private static readonly HttpClient client = new HttpClient();

        public static async Task<List<Teacher>> GetListTeacherAsync()
        {
            string url = "http://localhost:5019/api/Tearcher/GetAllTeacher";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<Teacher>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<Teacher>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<Teacher>();
            }
        }

        public static async Task<Teacher> GetTeacherByEmail(string email)
        {
            Teacher studentDTO = null; // Sửa tên biến để thống nhất với convention
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Tearcher/GetTeacherByEmail/{email}";

                HttpResponseMessage response = await client.GetAsync(url); // Sử dụng await để gọi bất đồng bộ

                if (response.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    studentDTO = await response.Content.ReadFromJsonAsync<Teacher>(); // Sử dụng await ở đây cũng
                }
            }

            return studentDTO; // Trả về đối tượng sinh viên
        }
    }
}
