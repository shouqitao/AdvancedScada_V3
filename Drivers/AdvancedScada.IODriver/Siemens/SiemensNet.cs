﻿using AdvancedScada.DriverBase;
using AdvancedScada.DriverBase.Comm;
using HslCommunication;
using HslCommunication.Profinet.Siemens;
using System;
using System.Diagnostics;
using System.Net.Sockets;

namespace AdvancedScada.IODriver.Siemens
{
    public   class SiemensNet: IDriverAdapter
    {
        private SiemensS7Net siemensTcpNet = null;
        private SiemensPLCS siemensPLCSelected = SiemensPLCS.S1200;
        private const int DELAY = 10;
        
        public bool _IsConnected = false;
        public byte station;
        private SiemensPLCS cpu;
        private string iPAddress;
        private short rack;
        private short slot;

        public bool IsConnected { get => _IsConnected; set => _IsConnected = value; }
        public byte Station { get => station; set => station = value; }

        public RequestAndResponseMessage RequestAndResponseMessage { get; } = null;

        public SiemensNet()
        {
        }

        public SiemensNet(SiemensPLCS cpu, string iPAddress, short rack, short slot) 
            : this()
        {
            
            this.cpu = cpu;
            this.iPAddress = iPAddress;
            this.rack = rack;
            this.slot = slot;
              siemensPLCSelected = cpu;
               siemensTcpNet = new SiemensS7Net(cpu);
            
        }

       
        

        public void Connection()
        {
            var stopwatch = Stopwatch.StartNew();

            try
            {

                siemensTcpNet.IpAddress = iPAddress;
                if (siemensPLCSelected != SiemensPLCS.S200Smart)
                {
                    siemensTcpNet.Rack = (byte) rack;
                    siemensTcpNet.Slot = (byte) slot;
                }


                OperateResult connect = siemensTcpNet.ConnectServer();

                try
                {
                    
                    if (connect.IsSuccess)
                    {

                        IsConnected = true;
                    }
                    else
                    {
                        IsConnected = false;
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }


                var err = new HMIException.ScadaException(IsConnected);
                stopwatch.Stop();
            }
            catch (SocketException ex)
            {
                stopwatch.Stop();

                var err = new HMIException.ScadaException(this.GetType().Name,
                    $"Could Not Connect to Server : {ex.SocketErrorCode}Time{stopwatch.ElapsedTicks}");

                var err1 = new HMIException.ScadaException(false);

            }
        }

        public void Disconnection()
        {
            try
            {
                siemensTcpNet.ConnectClose();
                var err = new HMIException.ScadaException(false);
            }
            catch (SocketException)
            {
            }
            finally
            {
                var err = new HMIException.ScadaException(false);


            }
        }
        public byte[] BuildReadByte(byte station, string address, ushort length)
        {


            var frame = DemoUtils.BulkReadRenderResult(siemensTcpNet, address, length);


            return frame;


        }

        public byte[] BuildWriteByte(byte station, string address, byte[] value)
        {
            try
            {
                DemoUtils.WriteResultRender(siemensTcpNet.Write(address, value), address);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return new byte[0];
        }


       
        public bool Write(string address, dynamic value)
        {
            if (value is bool)
            {
                siemensTcpNet.Write(address, value);
            }
            else
            {
                siemensTcpNet.Write(address, value);
            }

            return true;
        }

        public TValue[] Read<TValue>(string address, ushort length)
        {
            if (typeof(TValue) == typeof(bool))
            {
                var b = siemensTcpNet.Read(address, length).Content;
                return (TValue[])(object)b;
            }
            if (typeof(TValue) == typeof(ushort))
            {
                var b = siemensTcpNet.ReadUInt16(address, length).Content;

                return (TValue[])(object)b;
            }
            if (typeof(TValue) == typeof(int))
            {
                var b = siemensTcpNet.ReadInt32(address, length).Content;

                return (TValue[])(object)b;
            }
            if (typeof(TValue) == typeof(uint))
            {
                var b = siemensTcpNet.ReadUInt32(address, length).Content;
                return (TValue[])(object)b;
            }
            if (typeof(TValue) == typeof(long))
            {
                var b = siemensTcpNet.ReadInt64(address, length).Content;
                return (TValue[])(object)b;
            }
            if (typeof(TValue) == typeof(ulong))
            {
                var b = siemensTcpNet.ReadUInt64(address, length).Content;
                return (TValue[])(object)b;
            }

            if (typeof(TValue) == typeof(short))
            {
                var b = siemensTcpNet.ReadInt16(address, length).Content;
                return (TValue[])(object)b;
            }
            if (typeof(TValue) == typeof(double))
            {
                var b = siemensTcpNet.ReadDouble(address, length).Content;
                return (TValue[])(object)b;
            }
            if (typeof(TValue) == typeof(float))
            {
                var b = siemensTcpNet.ReadFloat(address, length).Content;
                return (TValue[])(object)b;

            }
            if (typeof(TValue) == typeof(string))
            {
                var b = siemensTcpNet.ReadString(address, length).Content;
                return (TValue[])(object)b;
            }

            throw new InvalidOperationException(string.Format("type '{0}' not supported.", typeof(TValue)));
        }

        public OperateResult<bool[]> ReadDiscrete(string address, ushort length)
        {
            throw new NotImplementedException();
        }
    }
}
