using BusinessObjects.DTO.ClassDTO;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;

namespace StudentAttendanceClient.APIFunction
{
    public class ClassAPI
    {
        private static readonly HttpClient client = new HttpClient();
        public static async Task<List<Class>> GetListClassAsync()
        {
            string url = "http://localhost:5019/api/Class/GetAllClass";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<Class>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<Class>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<Class>();
            }
        }
        public static async Task<ClassesDTO> GetClassByIdAsync(int id)
        {
            ClassesDTO classDTO = null; // Sửa tên biến để thống nhất với convention
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Class/{id}";

                HttpResponseMessage response = await client.GetAsync(url); // Sử dụng await để gọi bất đồng bộ

                if (response.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    classDTO = await response.Content.ReadFromJsonAsync<ClassesDTO>(); // Sử dụng await ở đây cũng
                }
            }

            return classDTO; // Trả về đối tượng sinh viên
        }
    }
}
