using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using Newtonsoft.Json;
using System.Text;

namespace StudentAttendanceClient.APIFunction
{
    public class StudentAPI
    {
        private static readonly HttpClient client = new HttpClient();
        public static async Task<List<StudentsDTO>> GetListStudentAsync()
        {
            string url = "http://localhost:5019/api/Student/GetAllStudent";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<StudentsDTO>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<StudentsDTO>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<StudentsDTO>();
            }
        }

        public static async Task<int> GetMaxStudentCodeAsync()
        {
            string url = "http://localhost:5019/api/Student/GetMaxStudentCode";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<int>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return 0; // Trả về 0 nếu có lỗi từ API
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return 0; // Trả về 0 nếu có lỗi HTTP
            }
        }

        public static async Task<StudentsDTO> GetStudentByIdAsync(int id)
        {
            StudentsDTO studentDTO = null; // Sửa tên biến để thống nhất với convention
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Student/GetStudentByID/{id}";

                HttpResponseMessage response = await client.GetAsync(url); // Sử dụng await để gọi bất đồng bộ

                if (response.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    studentDTO = await response.Content.ReadFromJsonAsync<StudentsDTO>(); // Sử dụng await ở đây cũng
                }
            }

            return studentDTO; // Trả về đối tượng sinh viên
        }

        public static async Task<int> CreateStudentAsync(AddStudentDTO p)
        {
            using (HttpClient client = new HttpClient())
            {
                string url = "http://localhost:5019/api/Student/AddStudent";
                string data = JsonConvert.SerializeObject(p);
                var httpContent = new StringContent(data, Encoding.UTF8, "application/json");

                try
                {
                    try
                    {
                        HttpResponseMessage httpResponse = await client.PostAsync(url, httpContent);

                        // Kiểm tra response từ API
                        if (httpResponse.IsSuccessStatusCode)
                        {
                            return (int)httpResponse.StatusCode; // Trả về mã trạng thái HTTP
                        }
                        else
                        {
                            // Log thêm chi tiết response nếu cần
                            return (int)httpResponse.StatusCode;
                        }
                    }
                    catch (HttpRequestException httpEx)
                    {
                        // Log lỗi khi request gặp vấn đề
                        // log httpEx.Message hoặc httpEx.ToString()
                        return -1; // Trả về -1 nếu có lỗi kết nối HTTP
                    }
                }
                catch (Exception ex)
                {
                    // Xử lý exception (có thể log lỗi)
                    return -1; // Trả về -1 nếu có lỗi
                }
            }
        }

        public static async Task<int> EditStudentAsync(UpdateStudentDTO p)
        {
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Student/UpdateStudent";
                HttpResponseMessage response = await client.PutAsJsonAsync(url, p);

                // Kiểm tra mã trạng thái và nội dung phản hồi
                if (response.IsSuccessStatusCode)
                {
                    return 200;
                }
                else
                {
                    string responseContent = await response.Content.ReadAsStringAsync();
                    Console.WriteLine($"Error updating product: {response.StatusCode} - {responseContent}");
                    return -1;
                }
            }
        }
        public static async Task<int> DeleteStudent(int id)
        {
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Student/DeleteStudent/{id}";
                var response = await client.DeleteAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return 200;
                }
                return -1;
            }
        }

    }
}
