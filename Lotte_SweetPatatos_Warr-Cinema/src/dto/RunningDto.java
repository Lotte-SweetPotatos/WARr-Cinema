package dto;

public class RunningDto {
   
   private int id;
   private int movie_id;
   private String reserveStartTime;
   private String reserveEndTime;
   private int runningTime;
   private String runningDate;
   private String cineName;
   private int totalSeat;
   private int curSeat;
   
   public RunningDto(int id, int movie_id, String reserveStartTime, String reserveEndTime, int runningTime,
         String runningDate, String cineName, int totalSeat, int curSeat) {
      super();
      this.id = id;
      this.movie_id = movie_id;
      this.reserveStartTime = reserveStartTime;
      this.reserveEndTime = reserveEndTime;
      this.runningTime = runningTime;
      this.runningDate = runningDate;
      this.cineName = cineName;
      this.totalSeat = totalSeat;
      this.curSeat = curSeat;
   }

   public int getId() {
      return id;
   }

   public void setId(int id) {
      this.id = id;
   }

   public int getMovie_id() {
      return movie_id;
   }

   public void setMovie_id(int movie_id) {
      this.movie_id = movie_id;
   }

   public String getReserveStartTime() {
      return reserveStartTime;
   }

   public void setReserveStartTime(String reserveStartTime) {
      this.reserveStartTime = reserveStartTime;
   }

   public String getReserveEndTime() {
      return reserveEndTime;
   }

   public void setReserveEndTime(String reserveEndTime) {
      this.reserveEndTime = reserveEndTime;
   }

   public int getRunningTime() {
      return runningTime;
   }

   public void setRunningTime(int runningTime) {
      this.runningTime = runningTime;
   }

   public String getRunningDate() {
      return runningDate;
   }

   public void setRunningDate(String runningDate) {
      this.runningDate = runningDate;
   }

   public String getCineName() {
      return cineName;
   }

   public void setCineName(String cineName) {
      this.cineName = cineName;
   }

   public int getTotalSeat() {
      return totalSeat;
   }

   public void setTotalSeat(int totalSeat) {
      this.totalSeat = totalSeat;
   }

   public int getCurSeat() {
      return curSeat;
   }

   public void setCurSeat(int curSeat) {
      this.curSeat = curSeat;
   }

   @Override
   public String toString() {
      return "RunningDto [id=" + id + ", movie_id=" + movie_id + ", reserveStartTime=" + reserveStartTime
            + ", reserveEndTime=" + reserveEndTime + ", runningTime=" + runningTime + ", runningDate=" + runningDate
            + ", cineName=" + cineName + ", totalSeat=" + totalSeat + ", curSeat=" + curSeat + "]";
   }
   
   
   
   

}