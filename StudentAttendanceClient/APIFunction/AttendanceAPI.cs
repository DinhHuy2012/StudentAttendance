using BusinessObjects.DTO.AttendanceDTO;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using Newtonsoft.Json;
using System.Net.Mail;
using System.Text;

namespace StudentAttendanceClient.APIFunction
{
    public class AttendanceAPI
    {
        private static readonly HttpClient client = new HttpClient();
        public static async Task<List<ViewAttendanceDTO>> GetAllAttendanceByScheduleID(int scheduleId, int classId)
        {
            string url = $"http://localhost:5019/api/Attendance/GetAllAttendanceByScheduleID/{scheduleId}/{classId}";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<ViewAttendanceDTO>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<ViewAttendanceDTO>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<ViewAttendanceDTO>();
            }
        }


        public static async Task<int> AddAttendanceAsync(int classId)
        {
            string url = "http://localhost:5019/api/Attendance/add-attendance";
            var data = JsonConvert.SerializeObject(classId);
            var httpContent = new StringContent(data, Encoding.UTF8, "application/json");

            try
            {
                // Gửi yêu cầu POST tới API
                HttpResponseMessage httpResponse = await client.PostAsync(url, httpContent);

                // Kiểm tra response từ API
                if (httpResponse.IsSuccessStatusCode)
                {
                    return (int)httpResponse.StatusCode; // Trả về mã trạng thái HTTP nếu thành công
                }
                else
                {
                    // Log thêm chi tiết response nếu cần
                    Console.WriteLine($"Thất bại khi thêm điểm danh: {httpResponse.ReasonPhrase}");
                    return (int)httpResponse.StatusCode;
                }
            }
            catch (HttpRequestException httpEx)
            {
                // Log lỗi khi request gặp vấn đề
                Console.WriteLine($"Lỗi kết nối HTTP: {httpEx.Message}");
                return -1; // Trả về -1 nếu có lỗi kết nối HTTP
            }
            catch (Exception ex)
            {
                // Xử lý exception (có thể log lỗi)
                Console.WriteLine($"Lỗi không xác định: {ex.Message}");
                return -1; // Trả về -1 nếu có lỗi không xác định
            }
        }
        public static async Task<int> UpdateAttendanceAsync(int scheduleId, int classId, List<AttendanceUpdateDTO> updates)
        {
            string url = $"http://localhost:5019/api/Attendance/UpdateAttendance/{scheduleId}/{classId}";

            // Kiểm tra xem danh sách updates có null hoặc rỗng không
            if (updates == null || !updates.Any())
            {
                throw new ArgumentException("Cần cung cấp ít nhất một cập nhật điểm danh.", nameof(updates));
            }

            // Chuyển đổi danh sách updates thành JSON mà không bao bọc trong đối tượng
            var json = JsonConvert.SerializeObject(updates, new JsonSerializerSettings
            {
                NullValueHandling = NullValueHandling.Ignore,
                Formatting = Formatting.Indented
            });

            // Log dữ liệu JSON gửi đi
            Console.WriteLine($"Dữ liệu JSON gửi đi: {json}");

            var httpContent = new StringContent(json, Encoding.UTF8, "application/json");

            try
            {
                // Gửi yêu cầu POST tới API
                HttpResponseMessage httpResponse = await client.PostAsync(url, httpContent);

                // Kiểm tra phản hồi từ API
                if (httpResponse.IsSuccessStatusCode)
                {
                    Console.WriteLine("Cập nhật điểm danh thành công!");
                    return (int)httpResponse.StatusCode; // Trả về mã trạng thái HTTP nếu thành công
                }
                else
                {
                    var responseContent = await httpResponse.Content.ReadAsStringAsync();
                    Console.WriteLine($"Thất bại khi cập nhật điểm danh: {httpResponse.ReasonPhrase}, Nội dung: {responseContent}");
                    return (int)httpResponse.StatusCode;
                }
            }
            catch (HttpRequestException httpEx)
            {
                Console.WriteLine($"Lỗi kết nối HTTP: {httpEx.Message}");
                return -1;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi không xác định: {ex.Message}");
                return -1;
            }
        }


    }
}
