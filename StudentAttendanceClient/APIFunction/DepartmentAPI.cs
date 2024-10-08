using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;

namespace StudentAttendanceClient.APIFunction
{
    public class DepartmentAPI
    {
        private static readonly HttpClient client = new HttpClient();
        public static async Task<List<Department>> GetListDepartmentAsync()
        {
            string url = "http://localhost:5019/api/Department/GetAllDepartment";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<Department>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<Department>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<Department>();
            }
        }
    }
}
