using BusinessObjects.Models;

namespace StudentAttendanceClient.APIFunction
{
    public class SemesterAPI
    {
        private static readonly HttpClient client = new HttpClient();
        public static async Task<List<Semester>> GetListSemesterAsync()
        {
            string url = "http://localhost:5019/api/Semester/GetAllSemester";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<Semester>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<Semester>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<Semester>();
            }   
        }

        public static async Task<Semester> GetSemesterByStatus()
        {
            string url = "http://localhost:5019/api/Semester/GetSemesterByStatus";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<Semester>();
                }
                else
                {
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return null; // Trả về null khi không thành công
                }
            }
            catch (HttpRequestException ex)
            {
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return null; // Trả về null trong trường hợp lỗi HTTP request
            }
        }

    }
}
