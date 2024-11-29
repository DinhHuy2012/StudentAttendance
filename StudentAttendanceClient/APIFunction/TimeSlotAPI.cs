using BusinessObjects.Models;

namespace StudentAttendanceClient.APIFunction
{
    public class TimeSlotAPI
    {
        private static readonly HttpClient client = new HttpClient();

        public static async Task<List<TimeSlot>> GetListTimeSlotAsync()
        {
            string url = "http://localhost:5019/api/TimeSlot/GetAllTimeSlot";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<TimeSlot>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<TimeSlot>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<TimeSlot>();
            }
        }
    }
}
