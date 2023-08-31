/*
  Warnings:

  - The values [FACULTY] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.
  - The primary key for the `AcademicRecord` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `studentId` on the `AcademicRecord` table. All the data in the column will be lost.
  - The primary key for the `Attendance` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `studentId` on the `Attendance` table. All the data in the column will be lost.
  - The primary key for the `Course` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `departmentId` on the `Course` table. All the data in the column will be lost.
  - You are about to drop the column `instituteId` on the `Course` table. All the data in the column will be lost.
  - The primary key for the `CourseDetail` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Department` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `instituteId` on the `Department` table. All the data in the column will be lost.
  - The primary key for the `Fee` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `financeId` on the `Fee` table. All the data in the column will be lost.
  - You are about to drop the column `schedule` on the `Fee` table. All the data in the column will be lost.
  - You are about to drop the column `studentId` on the `Fee` table. All the data in the column will be lost.
  - You are about to drop the column `studentId` on the `Grade` table. All the data in the column will be lost.
  - You are about to drop the column `value` on the `Grade` table. All the data in the column will be lost.
  - The primary key for the `PersonalInfo` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Salary` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `employeeId` on the `Salary` table. All the data in the column will be lost.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `Employee` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Finance` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FinancialReport` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Institute` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Student` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[name]` on the table `Department` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[shortName]` on the table `Department` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[employeeInfoId]` on the table `Salary` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `semesterId` to the `Course` table without a default value. This is not possible if the table is not empty.
  - Added the required column `shortName` to the `Department` table without a default value. This is not possible if the table is not empty.
  - Added the required column `payStatus` to the `Fee` table without a default value. This is not possible if the table is not empty.
  - Added the required column `final` to the `Grade` table without a default value. This is not possible if the table is not empty.
  - Added the required column `midterm` to the `Grade` table without a default value. This is not possible if the table is not empty.
  - Added the required column `address` to the `PersonalInfo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employeeInfoId` to the `Salary` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Rank" AS ENUM ('A', 'B', 'C', 'D', 'E', 'F');

-- CreateEnum
CREATE TYPE "PayStatus" AS ENUM ('QUATERLY', 'HALF_YEARLY', 'YEARLY');

-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('ADMIN', 'EMPLOYEE', 'STUDENT');
ALTER TABLE "User" ALTER COLUMN "role" DROP DEFAULT;
ALTER TABLE "User" ALTER COLUMN "role" TYPE "Role_new" USING ("role"::text::"Role_new");
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "Role_old";
ALTER TABLE "User" ALTER COLUMN "role" SET DEFAULT 'STUDENT';
COMMIT;

-- DropForeignKey
ALTER TABLE "AcademicRecord" DROP CONSTRAINT "AcademicRecord_studentId_fkey";

-- DropForeignKey
ALTER TABLE "Attendance" DROP CONSTRAINT "Attendance_studentId_fkey";

-- DropForeignKey
ALTER TABLE "Course" DROP CONSTRAINT "Course_departmentId_fkey";

-- DropForeignKey
ALTER TABLE "Course" DROP CONSTRAINT "Course_instituteId_fkey";

-- DropForeignKey
ALTER TABLE "CourseDetail" DROP CONSTRAINT "CourseDetail_courseId_fkey";

-- DropForeignKey
ALTER TABLE "CourseDetail" DROP CONSTRAINT "CourseDetail_userId_fkey";

-- DropForeignKey
ALTER TABLE "Department" DROP CONSTRAINT "Department_instituteId_fkey";

-- DropForeignKey
ALTER TABLE "Employee" DROP CONSTRAINT "Employee_instituteId_fkey";

-- DropForeignKey
ALTER TABLE "Employee" DROP CONSTRAINT "Employee_personalInfoId_fkey";

-- DropForeignKey
ALTER TABLE "Fee" DROP CONSTRAINT "Fee_financeId_fkey";

-- DropForeignKey
ALTER TABLE "Fee" DROP CONSTRAINT "Fee_studentId_fkey";

-- DropForeignKey
ALTER TABLE "Finance" DROP CONSTRAINT "Finance_instituteId_fkey";

-- DropForeignKey
ALTER TABLE "FinancialReport" DROP CONSTRAINT "FinancialReport_financeId_fkey";

-- DropForeignKey
ALTER TABLE "FinancialReport" DROP CONSTRAINT "FinancialReport_instituteId_fkey";

-- DropForeignKey
ALTER TABLE "Grade" DROP CONSTRAINT "Grade_courseDetailId_fkey";

-- DropForeignKey
ALTER TABLE "Grade" DROP CONSTRAINT "Grade_studentId_fkey";

-- DropForeignKey
ALTER TABLE "PersonalInfo" DROP CONSTRAINT "PersonalInfo_userId_fkey";

-- DropForeignKey
ALTER TABLE "Salary" DROP CONSTRAINT "Salary_employeeId_fkey";

-- DropForeignKey
ALTER TABLE "Student" DROP CONSTRAINT "Student_instituteId_fkey";

-- DropForeignKey
ALTER TABLE "Student" DROP CONSTRAINT "Student_personalInfoId_fkey";

-- AlterTable
ALTER TABLE "AcademicRecord" DROP CONSTRAINT "AcademicRecord_pkey",
DROP COLUMN "studentId",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "AcademicRecord_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "AcademicRecord_id_seq";

-- AlterTable
ALTER TABLE "Attendance" DROP CONSTRAINT "Attendance_pkey",
DROP COLUMN "studentId",
ADD COLUMN     "courseDetailId" TEXT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Attendance_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Attendance_id_seq";

-- AlterTable
ALTER TABLE "Course" DROP CONSTRAINT "Course_pkey",
DROP COLUMN "departmentId",
DROP COLUMN "instituteId",
ADD COLUMN     "employeeInfoId" TEXT,
ADD COLUMN     "semesterId" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Course_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Course_id_seq";

-- AlterTable
ALTER TABLE "CourseDetail" DROP CONSTRAINT "CourseDetail_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "userId" DROP NOT NULL,
ALTER COLUMN "userId" SET DATA TYPE TEXT,
ALTER COLUMN "courseId" SET DATA TYPE TEXT,
ADD CONSTRAINT "CourseDetail_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "CourseDetail_id_seq";

-- AlterTable
ALTER TABLE "Department" DROP CONSTRAINT "Department_pkey",
DROP COLUMN "instituteId",
ADD COLUMN     "shortName" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Department_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Department_id_seq";

-- AlterTable
ALTER TABLE "Fee" DROP CONSTRAINT "Fee_pkey",
DROP COLUMN "financeId",
DROP COLUMN "schedule",
DROP COLUMN "studentId",
ADD COLUMN     "payStatus" "PayStatus" NOT NULL,
ADD COLUMN     "sudentInfoId" TEXT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Fee_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Fee_id_seq";

-- AlterTable
ALTER TABLE "Grade" DROP COLUMN "studentId",
DROP COLUMN "value",
ADD COLUMN     "final" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "midterm" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "rank" "Rank" NOT NULL DEFAULT 'B',
ALTER COLUMN "courseDetailId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "PersonalInfo" DROP CONSTRAINT "PersonalInfo_pkey",
ADD COLUMN     "address" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "userId" SET DATA TYPE TEXT,
ADD CONSTRAINT "PersonalInfo_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "PersonalInfo_id_seq";

-- AlterTable
ALTER TABLE "Salary" DROP CONSTRAINT "Salary_pkey",
DROP COLUMN "employeeId",
ADD COLUMN     "employeeInfoId" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Salary_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Salary_id_seq";

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "User_id_seq";

-- DropTable
DROP TABLE "Employee";

-- DropTable
DROP TABLE "Finance";

-- DropTable
DROP TABLE "FinancialReport";

-- DropTable
DROP TABLE "Institute";

-- DropTable
DROP TABLE "Student";

-- CreateTable
CREATE TABLE "Major" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "shortName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Major_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Semester" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "shortName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "batchId" TEXT NOT NULL,

    CONSTRAINT "Semester_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Batch" (
    "id" TEXT NOT NULL,
    "number" INTEGER NOT NULL,
    "batchCode" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "majorId" TEXT NOT NULL,

    CONSTRAINT "Batch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StudentInfo" (
    "id" TEXT NOT NULL,
    "studentIdCard" TEXT NOT NULL,
    "userId" TEXT,
    "batchId" TEXT,

    CONSTRAINT "StudentInfo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmployeeInfo" (
    "id" TEXT NOT NULL,
    "employeeIdCard" TEXT NOT NULL,
    "hire_date" TIMESTAMP(3) NOT NULL,
    "departmentId" TEXT NOT NULL,
    "position" TEXT NOT NULL,
    "userId" TEXT,

    CONSTRAINT "EmployeeInfo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Major_name_key" ON "Major"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Major_shortName_key" ON "Major"("shortName");

-- CreateIndex
CREATE UNIQUE INDEX "Semester_name_key" ON "Semester"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Semester_shortName_key" ON "Semester"("shortName");

-- CreateIndex
CREATE UNIQUE INDEX "StudentInfo_studentIdCard_key" ON "StudentInfo"("studentIdCard");

-- CreateIndex
CREATE UNIQUE INDEX "StudentInfo_userId_key" ON "StudentInfo"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "EmployeeInfo_employeeIdCard_key" ON "EmployeeInfo"("employeeIdCard");

-- CreateIndex
CREATE UNIQUE INDEX "EmployeeInfo_userId_key" ON "EmployeeInfo"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Department_name_key" ON "Department"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Department_shortName_key" ON "Department"("shortName");

-- CreateIndex
CREATE UNIQUE INDEX "Salary_employeeInfoId_key" ON "Salary"("employeeInfoId");

-- AddForeignKey
ALTER TABLE "Semester" ADD CONSTRAINT "Semester_batchId_fkey" FOREIGN KEY ("batchId") REFERENCES "Batch"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Batch" ADD CONSTRAINT "Batch_majorId_fkey" FOREIGN KEY ("majorId") REFERENCES "Major"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentInfo" ADD CONSTRAINT "StudentInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentInfo" ADD CONSTRAINT "StudentInfo_batchId_fkey" FOREIGN KEY ("batchId") REFERENCES "Batch"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeInfo" ADD CONSTRAINT "EmployeeInfo_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "Department"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeInfo" ADD CONSTRAINT "EmployeeInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PersonalInfo" ADD CONSTRAINT "PersonalInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseDetail" ADD CONSTRAINT "CourseDetail_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseDetail" ADD CONSTRAINT "CourseDetail_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Attendance" ADD CONSTRAINT "Attendance_courseDetailId_fkey" FOREIGN KEY ("courseDetailId") REFERENCES "CourseDetail"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Grade" ADD CONSTRAINT "Grade_courseDetailId_fkey" FOREIGN KEY ("courseDetailId") REFERENCES "CourseDetail"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fee" ADD CONSTRAINT "Fee_sudentInfoId_fkey" FOREIGN KEY ("sudentInfoId") REFERENCES "StudentInfo"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Salary" ADD CONSTRAINT "Salary_employeeInfoId_fkey" FOREIGN KEY ("employeeInfoId") REFERENCES "EmployeeInfo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Course" ADD CONSTRAINT "Course_employeeInfoId_fkey" FOREIGN KEY ("employeeInfoId") REFERENCES "EmployeeInfo"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Course" ADD CONSTRAINT "Course_semesterId_fkey" FOREIGN KEY ("semesterId") REFERENCES "Semester"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
