
using BusinessObjects.DTO.ClassDTO;
using BusinessObjects.DTO.ScheduleDTO;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using Newtonsoft.Json;
using System.Text;

namespace StudentAttendanceClient.APIFunction
{
    public class ScheduleAPI
    {
        private static readonly HttpClient client = new HttpClient();

        public static async Task<List<ScheduleListDTO>> GetScheduleByclassIdAsync(int classId)
        {
            string url = $"http://localhost:5019/api/Schedule/GetScheduleByClassId/{classId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<ScheduleListDTO>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<ScheduleListDTO>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<ScheduleListDTO>();
            }
        }
        public static async Task<List<ScheduleListDTO>> GetScheduleByClassAndCourseAsync(int classId, int courseId)
        {
            string url = $"http://localhost:5019/api/Schedule/GetScheduleByClassAndCourseAsync/{classId}/{courseId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<ScheduleListDTO>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<ScheduleListDTO>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<ScheduleListDTO>();
            }
        }
        public static async Task<AddScheduleDTO> AddScheduleByClassIdAsync(int classId)
        {
            AddScheduleDTO classDTO = null; // Sửa tên biến để thống nhất với convention
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Schedule/AddScheduleByClassId/{classId}";

                HttpResponseMessage response = await client.GetAsync(url); // Sử dụng await để gọi bất đồng bộ

                if (response.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    classDTO = await response.Content.ReadFromJsonAsync<AddScheduleDTO>(); // Sử dụng await ở đây cũng
                }
            }

            return classDTO; // Trả về đối tượng sinh viên
        }

        public static async Task<ScheduleListDTO> GetScheduleByViewAttendanceId(int scheduleId)
        {
            ScheduleListDTO classDTO = null; // Sửa tên biến để thống nhất với convention
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Schedule/GetScheduleByScheduleId/{scheduleId}";

                HttpResponseMessage response = await client.GetAsync(url); // Sử dụng await để gọi bất đồng bộ

                if (response.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    classDTO = await response.Content.ReadFromJsonAsync<ScheduleListDTO>(); // Sử dụng await ở đây cũng
                }
            }

            return classDTO; // Trả về đối tượng sinh viên
        }


        public static async Task<EditScheduleDTO> GetScheduleByScheduleId(int scheduleId)
        {
            EditScheduleDTO classDTO = null; // Sửa tên biến để thống nhất với convention
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Schedule/GetScheduleByScheduleId/{scheduleId}";

                HttpResponseMessage response = await client.GetAsync(url); // Sử dụng await để gọi bất đồng bộ

                if (response.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    classDTO = await response.Content.ReadFromJsonAsync<EditScheduleDTO>(); // Sử dụng await ở đây cũng
                }
            }

            return classDTO; // Trả về đối tượng sinh viên
        }



        public static async Task<int> AddScheduleAsync(AddScheduleDTO addScheduleDTO)
        {
            using (HttpClient client = new HttpClient())
            {
                string url = "http://localhost:5019/api/Schedule/AddSchedule";
                string data = JsonConvert.SerializeObject(addScheduleDTO);
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

        public static async Task<int> EditScheduleAsync(EditScheduleDTO p)
        {
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Schedule/EditSchedule";
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

        public static async Task<int> DeleteSchedule(int id)
        {
            using (HttpClient client = new HttpClient())
            {
                string url = $"http://localhost:5019/api/Schedule/DeleteSchedule/{id}";
                var response = await client.DeleteAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return 200;
                }
                return -1;
            }
        }

        public static async Task<List<ScheduleListDTO>> GetSchedulesAsync(int teacherId)
        {

            string url = $"http://localhost:5019/api/Schedule/GetSchedulesAsync?teacherId={teacherId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<ScheduleListDTO>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<ScheduleListDTO>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<ScheduleListDTO>();
            }
        }
    }
}
