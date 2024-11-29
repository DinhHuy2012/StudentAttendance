using BusinessObjects.DTO.ClassDTO;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using Newtonsoft.Json;
using System.Text;

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
        public static async Task<Class> GetClassById(int id)
        {
            string url = $"http://localhost:5019/api/Class/get-class-by-id/{id}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    return await response.Content.ReadFromJsonAsync<Class>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new Class();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new Class();
            }

        }
        public static async Task<int> CreateClassAsync(AddClassDTO p)
        {
            using (HttpClient client = new HttpClient())
            {
                string url = "http://localhost:5019/api/Class/AddClass";
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
        public static async Task<int> EditClassAsync(Class updateClass)
        {
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Class/UpdateClass";
                HttpResponseMessage response = await client.PutAsJsonAsync(url, updateClass);

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
                string url = $"http://localhost:5019/api/Class/DeleteClass/{id}";
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
